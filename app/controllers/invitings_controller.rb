class InvitingsController < ApplicationController
  before_action :authenticate_user!
  def new
    @inviting = Inviting.new
  end
  def create
    @inviting = Inviting.new(inviting_params)
  end


private
def inviting_params
  require(:inviting).permit(:
end
