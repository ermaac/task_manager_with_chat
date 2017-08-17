class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:success] = "Profile updated"
    else
      flash[:error] = @profile.errors.full_messages.join('\n')
      render :edit
    end
    redirect_to @profile
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
                                    :avatar)
  end
end

