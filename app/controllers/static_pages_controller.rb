# frozen_string_literal: true
class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def about; end

  def help; end

  def contact; end
end
