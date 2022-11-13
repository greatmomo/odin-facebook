class UsersController < ApplicationController
  def index
    @users = User.all
    @friend_request = FriendRequest.new
  end
end
