class NotesController < ApplicationController
  before_action :set_current_note
  skip_before_action :set_current_note, only: :create
  before_action :list_enabled?

  def create
    @note = Note.new note_params
    @note.list_id = params[:list_id]
    flash[:notice] = "Error creating note" unless @note.save
    redirect_to dashboard_path(params[:board_id])
  end

  def destroy
    flash[:error] = "Error destroying note" unless @note.destroy
    redirect_to dashboard_path(params[:board_id])
  end

  def update
    flash[:error] = "Error updating note" unless @note.update note_params
    redirect_to dashboard_path(params[:board_id])
  end

  def move
    @note = Note.find params[:id]
    @lists = List.where(params[:board_id])
    @note.update(list_id: params[:list_id])
    redirect_to dashboard_path(params[:board_id])
  end

  private

  def note_params
    params.require(:note).permit(:text)
  end

  def set_current_note
    @note = Note.find_by id: params[:id]
    redirect_to dashboard_path(params[:board_id]), flash: {warning: 'Note not found'} unless @note
  end

  def list_enabled?
    list = @note ? @note.list : List.find(params[:list_id])
    board = list.board
    redirect_to dashboard_path(params[:board_id]), flash: {warning: "List is disabled!"} if list.is_disabled && current_user.id != board.creator_id
  end

end
