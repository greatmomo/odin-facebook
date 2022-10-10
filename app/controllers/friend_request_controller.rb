class FriendRequestController < ApplicationController
  def index
    @friendRequests = FriendRequest.all
  end
end
