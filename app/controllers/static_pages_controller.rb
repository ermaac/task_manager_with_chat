# frozen_string_literal: true
class StaticPagesController < ApplicationController
  def about
    if user_signed_in?
      redirect_to dashboards_path
    end
  end
end
