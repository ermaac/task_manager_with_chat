class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create(text: data['message'], user_id: current_user.id, chat_id: current_chat.id)
  end

  private

  def current_chat
    Chat.find_by board_id: params[:room]
  end
end
