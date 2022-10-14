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

      # # make friend requests for new user
      # new_user = User.last
      # User.first(10).each do |u|
      #   FriendRequest.create(requester_id: u.id, receiver_id: new_user.id, status: "pending")
      # end
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

  def friendRequest(requester, receiver)
    FriendRequest.create(requester_id: requester.id, receiver_id: receiver.id, status: "pending")
    redirect_to users_path
  end

  def acceptRequest(requester, receiver)
    
  end

  def denyRequest(requester, receiver)
  end
end
