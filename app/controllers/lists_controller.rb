# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :set_current_list
  skip_before_action :set_current_list, only: :create
  before_action :check_creator_of_board, only: :switch_editability
  before_action :list_enabled?
  skip_before_action :list_enabled?, only: [:create, :allowed_actions]

  respond_to :html, :js

  def create
    @list = List.new list_params
    @board = @list.board
    @note = Note.new
    @is_creator = current_user.id == @board.creator_id
    if @list.save
      list = render_to_string 'lists/_list', layout: false, locals: {list: @list}
      ActionCable.server.broadcast 'lists_channel', action: 'create', info: {list: list, id: @list.id}
    else
      redirect_to dashboards_path(params[:board_id]), flash: {error: "An error ocured while creating list"}
    end
  end

  def update
    if @list.update list_params
      ActionCable.server.broadcast 'lists_channel', action: 'update', info: {list_id: @list.id, title: @list.title}
    else
      flash[:error] = "An error ocured while updating list"
    end
  end

  def switch_editability
    @list.is_disabled = !@list.is_disabled
    @board = @list.board
    @note = Note.new
    @is_creator = current_user.id == @board.creator_id
    @lists = List.where board_id: params[:board_id]
    if @list.save
      list = render_to_string 'lists/_list_panel', layout: false, locals: {list: @list}
      ActionCable.server.broadcast 'lists_channel', action: 'switch_list_editability', info: {id: @list.id, list: list}
    end
  end

  def destroy
    @list.destroy
    ActionCable.server.broadcast "lists_channel", action: 'destroy', info: {id: @list.id}
  end

  def allowed_actions
    actions = get_actions
    respond_to do |format|
      format.js { render 'lists/allowed_actions', locals: {actions: actions, id: @list.id} }
    end
  end

  private

  def get_actions
    @list = List.find params[:id]
    board = @list.board
    Struct.new 'Actions', :hint, :icon_class, :method, :link_path, :data_toggle
    freeze = Struct::Actions.new 'freeze', 'fa fa-ban', :put, switch_list_editability_path(board, @list), nil
    freeze.hint = 'unfreeze' if @list.is_disabled
    delete = Struct::Actions.new 'delete', 'fa fa-times', nil, "#delete_list_#{@list.id}", 'modal'
    actions = []
    actions << freeze if board.creator_id == current_user.id
    actions << delete if board.creator_id == current_user.id || !@list.is_disabled
    actions
  end

  def list_params
    params.require(:list).permit(:title, :is_disabled).merge(board_id: params['board_id'])
  end

  def check_creator_of_board
    redirect_to dashboard_path(params[:board_id]), flash: {warning: "You have no permissions to perform this action"} unless current_user.id == @list.board.creator_id
  end

  def set_current_list
    @list = List.find_by id: params[:id]
    redirect_to dashboard_path(params[:id]), flash: {warning: 'List not found'} unless @list
  end

  def list_enabled?
    board = Board.find params[:board_id]
    redirect_to dashboard_path(params[:board_id]), flash: {warning: "List is disabled!"} if @list.is_disabled && current_user.id != board.creator_id
  end
end
