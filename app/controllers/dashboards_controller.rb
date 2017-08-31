# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :set_glob, only: :show
  authorize_resource class: false
  skip_authorize_resource only: [:index, :create]
  #before_action :authenticate_user!, only: %i(index show)
  before_action :find_board, only: :show
  after_action :create_invited_user_permissions, only: :create

  respond_to :js, :html
  helper DashboardsHelper

  def index
    if current_user
      @board = Board.new
      @boards = current_user.boards
      @invitation_count = Invitation.where(user_to_invite_id: current_user.id).count
    else
      redirect_to user_session_path
    end
  end

  def show
    if current_user.profile.first_name
      @lists = @board.lists.includes(:notes).order('created_at asc')
      @list = List.new
      @note = Note.new
      @is_creator = @board.creator_id == current_user.id
      cookies[:board_id] = params[:id]
      @messages = @board.chat.messages.last(50)
    else
      redirect_to edit_profile_path(current_user.id)
      flash[:danger] = "First name and Last name can't be blank"
    end
  end

  def create
    user_board = UserBoard.new(user_board_params)
    if user_board.save
      ActionCable.server.broadcast "boards_channel_#{params[:board_id]}", action: 'join_user', info: { user_id: current_user.id }
      redirect_to root_path
      flash[:success] = 'You have successfully joined to board'
    else
      redirect_to invitations_path
    end
  end

  def destroy
    deleted_user = UserBoard.where(prepare_delete_user_params).first
    if deleted_user.destroy
      flash[:success] = "You successfuly deleted user #{@user.profile.first_name}"
      ActionCable.server.broadcast "boards_channel_#{params[:id]}", action: 'kick_user', info: { id: @user_id }
      UsersChannel.broadcast_to @user, action: 'leave_board', info: { id: "board_#{params[:id]}" }
    else
      flash[:warning] = 'Something went wrong'
    end
  end

  def join_user
    @board = Board.find params[:id]
    user = User.find params[:user_id]
    respond_to do |format|
      format.js { render 'joined_user.js.erb', locals: { user: user } }
    end
  end

  private


  def set_glob
    $board_id = Board.find(params[:id])
  end

  def user_board_params
    board_id = params[:board_id]
    Invitation.where(board_id: board_id, user_to_invite_id: current_user.id).first.destroy
    { user_id: current_user.id, board_id: board_id }
  end

  def prepare_delete_user_params
    @user_id = params[:user_id]
    @user = User.find @user_id
    board_id = params[:id]
    { user_id: @user_id, board_id: board_id }
  end

  def find_board
    return if @board = current_user.boards.find_by(id: params[:id])
    flash[:warning] = 'You are not accepted in this board'
    redirect_to root_path
  end

  def create_invited_user_permissions
    InvitedUserPermission.create(user_id: current_user.id, board_id: params[:board_id])
  end
end
