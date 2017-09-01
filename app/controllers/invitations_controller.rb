# frozen_string_literal: true

class InvitationsController < ApplicationController
  authorize_resource
  skip_authorize_resource only: [:index, :create, :destroy, :notificate]
  before_action :user_email_presence, only: :create

  def index
    @invite = Invitation.where(user_to_invite_id: current_user.id)
  end

  def create
    @invitation = Invitation.new(prepare_params)
    if @invitation.save
      flash[:notice] = 'Invitation was succesfully sent'
    else
      flash[:alert] = "Something went wrong: invitation wasn't sent"
    end
      redirect_to invitations_path
  end

  def destroy
    invite_id = params[:id]
    @invite = Invitation.find(invite_id).destroy
    redirect_to invitations_path
  end

  def notificate
    @invitation_count = Invitation.where(user_to_invite_id: current_user.id).count
    render 'shared/notificate'
  end

  private

  def prepare_params
    board_title = params[:send][:board_title].chomp
    inviting_user = params[:send][:inviting_user].chomp
    invitor_id = current_user.id
    board_id = current_user.boards.find_by(title: board_title).id
    user_to_invite_id = User.find_by(email: inviting_user).id
    { board_id: board_id, invitor_id: invitor_id, user_to_invite_id: user_to_invite_id }
  end

  def user_email_presence
    unless User.find_by(email: params[:send][:inviting_user])
      flash[:warning] = "this user don't exist"
      redirect_to invitations_path
    end
  end
end
