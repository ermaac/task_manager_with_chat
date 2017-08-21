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
    if @note.destroy
      ActionCable.server.broadcast 'notes_channel', action: 'destroy', info: {id: "note_#{@note.id}"}
    else
      flash[:error] = "Error destroying note"
    end
    # redirect_to dashboard_path(params[:board_id])
  end

  def update
    if @note.update note_params
      ActionCable.server.broadcast 'notes_channel', action: 'update', info: {text: @note.text, id: "note_#{@note.id}"}
    else
      flash[:error] = "Error updating note"
    end
    # redirect_to dashboard_path(params[:board_id])
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
