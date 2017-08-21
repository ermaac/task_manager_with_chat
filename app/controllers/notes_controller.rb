class NotesController < ApplicationController
  before_action :set_current_note
  skip_before_action :set_current_note, only: :create

  def create
    note = Note.new note_params
    note.list_id = params[:list_id]
    if note.save
      ActionCable.server.broadcast "lists_channel",
        note: render_note(note),
        list_id: params[:list_id]
    else
      flash[:notice] = "Error creating note"
      #    flash[:notice] = "Error creating note" unless @note.save
      #    redirect_to dashboard_path(params[:board_id])
    end
  end

  def destroy
    flash[:error] = "Error destroying note" unless @note.destroy
    redirect_to dashboard_path(params[:board_id])
  end

  def update
    flash[:error] = "Error updating note" unless @note.update note_params
    redirect_to dashboard_path(params[:board_id])
  end

  private

  def render_note(note)
    list = List.find(params[:list_id])
    @board = list.board
    render(partial: 'notes/note', locals:{note: note,list: list,board: @board})
  end

  def note_params
    params.require(:note).permit(:text)
  end

  def set_current_note
    @note = Note.find params[:id]
  end
end
