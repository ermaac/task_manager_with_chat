class DashboardController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @board = Board.new
    @boards = current_user.boards
    render 'static_pages/home'
  end

  def show
    session[:board_id] = params[:id]
    @board = Board.find params[:id]
    @lists = @board.lists
    @list = List.new
    @note = Note.new
  end
end
