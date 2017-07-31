class BoardsController < ApplicationController
  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
    render 'new'
  end

  def create

  end


  def delete
  end

  def update
  end
end
