class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid, name: auth.info.name).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      end
  end

  has_many :posts

  has_many :friend_requests_as_requester, foreign_key: :requester_id, class_name: "FriendRequest"
  has_many :requested, through: :friend_requests_as_requester
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: "FriendRequest"
  has_many :received, through: :friend_requests_as_receiver

  def requestStatus(user)
    request = self.friend_requests_as_requester.find{|request| request.receiver_id == user.id}
    if request.nil?
      return "none"
    end
    request.status
  end

  def friendRequest(receiver)
    # Grab the target user
    # receiver = User.all.find(|receiver| receiver.id == user.id)
    # Create a friend request with that user and current user id
    FriendRequest.create(requester_id: current_user.id, receiver_id: receiver.id, status: "pending")
    # Redirect back to friend requests list
    # redirect_to users_path
  end
end

# add a controller action to your corresponding controller like,

# def ban_user
#  @user = User.find(params[:id])
#  @user.deactivated("true")
# end
# add this action to your routes.rb

# get 'controller/ban_user'
# now you can add the link to your views

# <%= link_to 'Ban User', controller_user_ban_path(:id => @user.id), class:"button is-danger", remote: true %>
# this will call the function without loading the page.
