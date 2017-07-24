class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    render html: "hello world"
  end
end
