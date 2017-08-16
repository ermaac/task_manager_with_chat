# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    identified_by :current_chat

    def connect
      self.current_user = find_verified_user
      self.current_chat = find_current_chat
      logger.add_tags 'ActionCable', current_user.email
    end

    protected
    def find_verified_user
      # User.find_by_id cookies.signed['user.id'] || reject_unauthorized_connection
      env['warden'].user || reject_unauthorized_connection
    end

    def find_current_chat
      Chat.find_by board_id: cookies[:board_id]
    end
  end
end
