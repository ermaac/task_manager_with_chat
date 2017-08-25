class BoardsController < ApplicationController
  def create
    @board = Board.new(board_params)
    @board.creator_id = current_user.id
    if @board.save
      UserBoard.create user: current_user, board: @board
      Chat.create(board_id: @board.id)
    else
      flash[:warning] = 'Fill the form'
    end
    redirect_to root_path
  end

  def destroy
    @board = Board.find params[:id]
    if @board.destroy
      ActionCable.server.broadcast "boards_channel_#{params[:id]}", action: 'destroy', info: { id: @board.id, location: '/' }
      ActionCable.server.broadcast 'boards_channel_0', id: params[:id]
    else
      flash[:notice] = "Error destroying board"
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :description)
  end
end
