# frozen_string_literal: true

class ListsController < ApplicationController
  authorize_resource
  before_action :set_current_list
  skip_before_action :set_current_list, only: :create
  before_action :check_creator_of_board, only: :switch_editability

  def create
    @list = List.new list_params
    flash[:error] = "An error ocured while creating list" unless @list.save
    redirect_to dashboard_path(params[:board_id])
  end

  def update
    flash[:error] = "An error ocured while updating list" unless @list.update list_params
    redirect_to dashboard_path(params[:board_id])
  end

  def switch_editability
    @list.is_disabled = !@list.is_disabled
    @list.save
    redirect_to dashboard_path(params[:board_id])
  end

  def destroy
    @list.destroy
    redirect_to dashboard_path(params[:board_id])
  end

  private

  def list_params
    params.require(:list).permit(:title, :is_disabled).merge(board_id: params['board_id'])
  end

  def check_creator_of_board
    redirect_to dashboard_path(params[:board_id]) unless current_user.id == @list.board.creator_id
  end

  def set_current_list
    @list = List.find params[:id]
  end
end
