# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    id = session[:board_id]
    @board = Board.find id
    @lists = @board.lists.order('created_at asc')
    @list = List.new
    @note = Note.new
  end

  def new
  end

  def create
    @list = List.new list_params
    flash[:error] = "An error ocured while creating list" unless @list.save
    redirect_to dashboard_path(session[:board_id])
  end

  def update
    @list = List.find params[:id]
    flash[:error] = "An error ocured while updating list" unless @list.update list_params
    redirect_to dashboard_path(session[:board_id])
  end

  def switch_editability
    list = List.find params[:id]
    list.is_disabled = !list.is_disabled
    list.save
    redirect_to dashboard_path(session[:board_id])
  end

  def destroy
    @list = List.find params[:id]
    @list.destroy
    redirect_to dashboard_path(session[:board_id])
  end

  private

  def list_params
    params.require(:list).permit(:title, :is_disabled).merge(board_id: session['board_id'])
  end
end
