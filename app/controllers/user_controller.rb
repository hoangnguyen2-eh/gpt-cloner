class UserController < ApplicationController
  def index
    @users = User.all
  end

  def getUserById
    @users = User.find(params[:id])
  end
end
