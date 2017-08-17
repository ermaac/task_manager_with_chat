# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_user.profile.first_name
      root_path
    else
      #flash[:error] = "First name and Last name can't be blank"
      edit_profile_path(current_user.id)
    end
  end
end
