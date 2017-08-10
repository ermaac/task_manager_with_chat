class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :current_user_board, only: :show

  def current_user_board
    user_boards = User.find(current_user.id).boards
    if !user_boards.ids.include?(params[:id].chomp.to_i)
      flash[:warning] = "you don't have accepted to this board"
      redirect_to root_path
    end
  end
  def index
    @board = Board.new
    @boards = current_user.boards
    @number = Invitation.where(user_to_invite_id: current_user.id).count
  end
  helper DashboardsHelper
  def show
    session[:board_id] = params[:id]
    @board = Board.find params[:id]#fix
    @lists = @board.lists
    @list = List.new
    @note = Note.new
  end
  def create
    user_board = UserBoard.new(user_board_params)

    if user_board.save
      redirect_to root_path
      flash[:success] = "You successfully connect to board "
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
end
