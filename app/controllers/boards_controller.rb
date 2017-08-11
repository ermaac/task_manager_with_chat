class BoardsController < ApplicationController
  def create
    @board = Board.new(board_params)
    @board.creator_id = current_user.id
    if @board.save
      UserBoard.create user: current_user, board: @board
    else
      flash[:warning] = 'Fill the form'
    end
    redirect_to root_path
  end

  def destroy
    @board = Board.find params[:id]
    if @board.destroy
      redirect_to root_path
    else
      flash[:notice] = "Error destroying board"
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :description)
  end
end
