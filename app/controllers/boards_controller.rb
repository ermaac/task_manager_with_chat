class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    id = params[:id]
    session[:board_id] = id
    redirect_to lists_path
  end

end
