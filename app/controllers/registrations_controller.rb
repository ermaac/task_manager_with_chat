class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    #flash[:error] = "First name and Last name can't be blank"
    edit_profile_path(current_user.id)
  end
end
