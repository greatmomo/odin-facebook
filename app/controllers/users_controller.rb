class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def friendRequest
    # Grab the target user
    @receiver = User.all.find(params[:id])
    # Create a friend request with that user and current user id
    FriendRequest.create(requester_id: current_user.id, receiver_id: @receiver.id, status: "pending")
    # Redirect back to friend requests list
    redirect_to users_path
  end
  
  # this logic seems to be javascript, needs to be modified to work with rails

  # const postFriendRequest = (target) => {
  #   const u1 = currentUser
  #   const u2 = target
  #   fetch('http://localhost:3000/friend_requests',{
  #     method: 'POST',
  #     headers: {
  #       'Content-Type': 'application/json',
  #       'Accept': 'application/json'
  #     },
  #     body: JSON.stringify({
  #       requester_id: u1.id,
  #       receiver_id: u2,
  #       status: "pending"
  #     })
  #   })
  # }

  # const handleAcceptBtn = (target) => {
  #   fetch('http://localhost:3000/friend_requests/${target}', {
  #     method: 'PATCH',
  #     headers: {
  #       'Content-Type': 'application/json',
  #       'Accept': 'application/json'
  #     },
  #     body: JSON.stringify({
  #       id: target,
  #       status: "accepted"
  #     })
  #   }).then(getFriends())
  # }

  # const handleDeclineBtn = (target) => {
  #   fetch('http://localhost:3000/friend_requests/${target}', {
  #     method: 'DELETE'
  #   }).then(getFriends())
  # }

#   Once the request is accepted its as easy to show as it was to show pending requests.
#   if ((request.requestor.id == u1.id || request.receiver.id == u1.id) && request.status == 'accepted'){
end
