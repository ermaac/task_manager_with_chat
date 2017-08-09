class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :board_exist, :user_email_presence, only: :create
  def index
    @invite = Invitation.where(user_to_invite_id: current_user.id)
  end

  def new
  end

  def create
    @invitation = Invitation.new(prepare_params)
    if @invitation.save
      flash[:success] = "inviting successfuly was sent"
      redirect_to invitations_path
    else
      flash[:warning] = "inviting  wasn't sent"
      redirect_to invitations_path
    end
  end

  def destroy
    invite_id = params[:id]
    @invite = Invitation.find(invite_id).destroy
    redirect_to invitations_path
  end
  def board_exist
    if Board.where(title: params[:send][:board_title].chomp).count == 0
      flash[:warning] = "this board don't exist"
      redirect_to invitations_path
    end
  end
  def user_email_presence
    if User.where(email: params[:send][:inviting_user].chomp).count == 0
      flash[:warning] = "this user don't exist"
      redirect_to invitations_path
    end
  end
  private
  def prepare_params
    board_title = params[:send][:board_title].chomp
    inviting_user = params[:send][:inviting_user].chomp
    invitor_id = current_user.id
    board_id = current_user.boards.find_by(title: board_title).id
    user_to_invite_id = User.find_by(email:inviting_user).id
    inviting_params = {board_id: board_id,invitor_id: invitor_id,user_to_invite_id: user_to_invite_id}
  end

end
