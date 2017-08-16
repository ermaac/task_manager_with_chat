class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  authorize_resource

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @profile
    else
      flash[:error] = @profile.errors.full_messages.join('\n')
      redirect_to @profile
    end
  end

  private

  def set_user
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def profile_params
    params.require(:profile).permit(:first_name,
                                    :last_name,
                                    :birthdate,
                                    :sex,
                                    :phone,
                                    :photo_url)
  end
end
