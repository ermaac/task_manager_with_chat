# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:success] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:success] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Github'
    else
      session['devise.github_data'] = request.env['omniauth.auth']
      redirect_to new_user_session_url
      flash[:alert] = I18n.t 'devise.omniauth_callbacks.failure', kind: 'Github'
    end
  end

  def vkontakte
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:success] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Vkontakte'
    else
      session['devise.vkontakte_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
