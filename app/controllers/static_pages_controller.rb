# frozen_string_literal: true
class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @user = current_user
    @board = Board.new
    @number = Inviting.where(user_to_invite_id: current_user.id).count
  end

  def about; end

  def help; end

  def contact; end
end
