class FriendRequestController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, except: [:create, :index]

  def index
    @friendRequests = FriendRequest.all
  end

  def create
    friend_request = FriendRequest.create(requester_id: current_user.id, receiver_id: params[:receiver_id], status: "pending")
    if friend_request.save
      redirect_back fallback_location: friend_request_index_path, notice: 'Friend Request sent!'
    else
      redirect_back fallback_location: friend_request_index_path, alert: "Sorry, your request could not be completed. (#{friend_request.errors.full_messages.join(', ')}.)"
    end
  end

  def confirm
    if @friend_request.receiver == current_user
      FriendRequest.create(receiver_id: @friend_request.receiver.id, requester_id: @friend_request.requester.id,
      status: "accepted")
      # FriendRequest.create(requester_id: u.id, receiver_id: new_user.id, status: "pending")
      @friend_request.destroy
      redirect_back fallback_location: friend_request_index_path, notice: 'Friend Request accepted!'
    else
      flash[:alert] = 'You are not authorized to accept this friend request.'
      redirect_to root_url
    end
  end

  def delete
    if @friend_request.receiver == current_user
      @friend_request.destroy
      redirect_back fallback_location: friend_request_index_path, notice: 'Friend Request was successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this friend request.'
      redirect_to root_url
    end
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
