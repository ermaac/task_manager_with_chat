class DashboardsController < ApplicationController
  authorize_resource class: false
  before_action :find_board, only: :show

  def index
    @board = Board.new
    @boards = current_user.boards
    @number = Invitation.where(user_to_invite_id: current_user.id).count
  end

  def show
    @lists = @board.lists.includes(:notes).order('created_at asc')
    @list = List.new
    @note = Note.new
    @is_creator = @board.creator_id == current_user.id
    cookies[:board_id] = params[:id]
    @messages = @board.chat.messages.last(10)
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

  def create_message
    Message.create(text: data['message'], user_id: current_user.id, chat_id: Chat.find_by(id: id).id)
  end

  private

  def user_board_params
    board_id = params[:board_id]
    Invitation.where(board_id: board_id, user_to_invite_id: current_user.id).first.destroy
    {user_id: current_user.id, board_id: board_id}
  end

  def find_board
    unless @board = current_user.boards.find_by(id: params[:id])
      flash[:warning] = "You are not accepted in this board"
      redirect_to root_path
    end
  end
end
