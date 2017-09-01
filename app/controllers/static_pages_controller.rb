# frozen_string_literal: true
class StaticPagesController < ApplicationController
  before_action :check, only: [:about]
  def about
  end

  private
  def check
    redirect_to dashboards_path if user_signed_in?
  end  
end
