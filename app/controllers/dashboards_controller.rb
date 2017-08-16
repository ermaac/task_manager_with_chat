class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :find_board, only: :show

  helper DashboardsHelper

  def index
    @board = Board.new
    @boards = current_user.boards
    @invitation_count = Invitation.where(user_to_invite_id: current_user.id).count
  end

  def show
    @lists = @board.lists.includes(:notes).order('created_at asc')
    @list = List.new
    @note = Note.new
    @is_creator = @board.creator_id == current_user.id
    cookies[:board_id] = params[:id]
    @messages = @board.chat.messages.last(100)
  end

  def create
    user_board = UserBoard.new(user_board_params)
    if user_board.save
      redirect_to root_path
      flash[:success] = "You have successfully joined to board "
    else
      redirect_to invitations_path
    end
  end

  def destroy
    deleted_user = UserBoard.where(prepare_delete_user_params).first
    if deleted_user.destroy
      flash[:success] = "You successfuly deleted user #{User.find(@user_id).profile.first_name}"
      redirect_to root_path
    else
      flash[:warning] = "Something went wrong"
    end
  end

  def create_message
    Message.create(text: data['message'], user_id: current_user.id, chat_id: Chat.find_by(id: id).id)
  end

  private

  def user_board_params
    board_id = params[:board_id]
    Invitation.where(board_id: board_id, user_to_invite_id: current_user.id).first.destroy
    {user_id: current_user.id, board_id: board_id}
  end

  def prepare_delete_user_params
    @user_id = params[:user_id]
    board_id = params[:id]
    {user_id: @user_id, board_id: board_id}
  end

  def find_board
    unless @board = current_user.boards.find_by(id: params[:id])
      flash[:warning] = "You are not accepted in this board"
      redirect_to root_path
    end
  end
end
