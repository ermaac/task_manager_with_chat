# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_current_note
  skip_before_action :set_current_note, only: :create
  before_action :list_enabled?

  def create
    note = Note.new note_params
    note.list_id = params[:list_id]
    if note.save
      ActionCable.server.broadcast "notes_channel_#{params[:board_id]}",
                                   note: render_note(note),
                                   list_id: params[:list_id],
                                   action: params[:action]
    else
      flash[:alert] = 'Error creating note'
    end
  end

  def destroy
    if @note.destroy
      ActionCable.server.broadcast "notes_channel_#{params[:board_id]}",
                                   action: params[:action],
                                   note_id: params[:id],
                                   list_id: params[:list_id]
    else
      flash[:alert] = 'Error destroying note'
    end
  end

  def update
    if @note.update note_params
      ActionCable.server.broadcast "notes_channel_#{params[:board_id]}",
                                   action: params[:action],
                                   note_id: params[:id],
                                   note_text: params[:note][:text]
    else
      flash[:alert] = 'Error updating note'
    end
  end

  def move
    note = Note.find params[:id]
    current_note_id = note.list_id
    @lists = List.where(board_id: params[:board_id])
    return unless note.update(list_id: params[:list_id])
    ActionCable.server.broadcast "notes_channel_#{params[:board_id]}",
                                 current_note_list_id: current_note_id,
                                 note: render_note(note),
                                 note_id: note.id,
                                 list_id: params[:list_id],
                                 action: params[:action]
  end

  private

  def render_note(note)
    @lists = List.where(board_id: params[:board_id])
    list = List.find(params[:list_id])
    @board = list.board
    render(partial: 'notes/note', locals: { note: note, list: list, board: @board, lists: @lists })
  end

  def note_params
    params.require(:note).permit(:text)
  end

  def set_current_note
    @note = Note.find_by id: params[:id]
    redirect_to dashboard_path(params[:board_id]), flash: { warning: 'Note not found' } unless @note
  end

  def list_enabled?
    list = @note ? @note.list : List.find(params[:list_id])
    board = list.board
    redirect_to dashboard_path(params[:board_id]), flash: { warning: 'List is disabled!' } if list.is_disabled && current_user.id != board.creator_id
  end
end
