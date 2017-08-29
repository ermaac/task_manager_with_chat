# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.js { head :forbidden }
      format.json { head :forbidden }
      format.html { redirect_to new_user_session_path, alert: exception.message }
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.profile.first_name
      root_path
    else
      edit_profile_path(current_user.id)
    end
  end
end
