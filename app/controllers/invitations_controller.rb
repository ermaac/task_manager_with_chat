class InvitationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @invite = Invitation.where(user_to_invite_id: current_user.id)
  end

  def new
  end

  def create
    @board_title = params[:send][:board_title]
    @inviting_user = params[:send][:inviting_user]
    @board_id = Board.find_by(title:@board_title).id
    @invitor_id = current_user.id
    @user_to_invite_id = User.find_by(email:@inviting_user).id
    inviting_params = {board_id: @board_id,invitor_id: @invitor_id,user_to_invite_id: @user_to_invite_id}
    @invitation = Invitation.new(inviting_params)
    if @invitation.save
      flash[:success] = "inviting successfuly was sent"
      redirect_to invitations_path
    else
      flash[:warning] = "inviting  wasn't sent"
      redirect_to invitations_path
    end
  end

  def destroy
    @invite = Invitation.find_by(user_to_invite_id: current_user.id).destroy
    redirect_to invitations_path
  end

end
