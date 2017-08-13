class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create(text: data['message'], user_id: current_user.id, chat_id: current_chat.id)
  end

   # def current_user
   #   @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
   # end

   # def current_chat
   # end
end
