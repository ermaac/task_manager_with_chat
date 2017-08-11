class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new note_params
    if @note.save
      redirect_to lists_path
    else
      flash[:notice] = "Error creating note"
    end
  end

  def destroy
    @note = Note.find params[:id]
    if @note.destroy
      redirect_to lists_path
    else
      flash[:notice] = "Error destroying note"
    end
  end

  def update
    @note = Note.find params[:id]
    @lists = List.where(board_id: session[:board_id])
    @note.update(list_id: params[:list_id])
    redirect_to lists_path
  end 

  private

  def note_params
    params.require(:note).permit(:text, :list_id)
  end
end
