# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    id = session[:board_id]
    @board = Board.find id
    @lists = @board.lists
    @list = List.new
    @note = Note.new
    @messages = @board.chat.messages
  end

  def new
  end

  def create
    @list = List.new list_params
    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def edit
    @list = List.find params[:id]
    @action = 'update'
    @form_name = 'Edit list'
    render :edit
  end

  def update
    @list = List.find params[:id]
    if @list.update list_params
      redirect_to lists_path
    else
      render :edit
    end
  end

  def destroy
    @list = List.find params[:id]
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:title).merge(board_id: session['board_id'])
  end
end
