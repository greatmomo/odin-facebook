class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def friendRequest
  end
end
