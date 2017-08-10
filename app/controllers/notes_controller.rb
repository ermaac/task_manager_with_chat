class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new note_params
    flash[:notice] = "Error creating note" unless @note.save
    redirect_to dashboard_path(session[:board_id])
  end

  def destroy
    @note = Note.find params[:id]
    flash[:error] = "Error destroying note" unless @note.destroy
    redirect_to dashboard_path(session[:board_id])
  end

  def update
    @note = Note.find params[:id]
    flash[:error] = "Error updating note" unless @note.update note_params
    redirect_to dashboard_path(session[:board_id])
  end

  private

  def note_params
    params.require(:note).permit(:text, :list_id)
  end
end
