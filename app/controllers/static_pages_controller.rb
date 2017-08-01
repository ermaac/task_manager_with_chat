# frozen_string_literal: true
class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def home
      @profile = Profile.find(current_user.id)
      @board = Board.new
  end

  def about; end

  def help; end

  def contact; end
end
