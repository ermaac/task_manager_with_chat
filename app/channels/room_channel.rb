class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create(text: data['message'], user_id: current_user.id, chat_id: 1)
  end



end

# Board.create! title:'sadsadsadsa', description: 'asdasdsadsa' => Board:0x000000047aeaf0 id: 5,
# Chat.create! board_id: 5 =>=> #<Chat:0x000000046b8128 id: 1, board_id: 5, enabled: nil>
# Message.create! text: '123', user_id: 1, chat_id: 1
