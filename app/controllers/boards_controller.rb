class BoardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @board = Board.new
  end

  def show
    session[:board_id] = params[:id]
    redirect_to lists_path
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to root_path
    else
      flash[:warning] = 'Fill the form'
      redirect_to root_path
    end
  end

  def destroy
    @board = Board.find params[:id]
    if @board.destroy
      redirect_to '/'
    else
      flash[:notice] = "Error destroying board"
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :description).merge(user_id: current_user.id)  #something may go wrong
  end
end
