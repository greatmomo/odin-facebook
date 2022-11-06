class FriendRequestController < ApplicationController
  def index
    @friendRequests = FriendRequest.all
  end

  def new
    @friendRequest = FriendRequest.new
  end

  def create
    @friendRequest = FriendRequest.new(friend_request_params)
    p "Friend request create has been called!"

    respond_to do |format|
      if @friendRequest.save
        format.html { redirect_to post_url(@friendRequest), notice: "Friend Request was successfully created." }
        format.json { render :show, status: :created, location: @friendRequest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friendRequest.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def friend_request_params
      params.require(:friendRequest).permit(:requester_id, :receiver_id, :status)
    end
end
