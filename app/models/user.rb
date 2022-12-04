class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]
  
  def self.from_omniauth(auth)
    new_user = where(provider: auth.provider, uid: auth.uid, name: auth.info.name).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.profile = Profile.where(user_id: user.id).first_or_create do |profile|
        profile.user_id = user.id
        profile.bio = ""
      end
    end

    User.first(5).each do |u|
      FriendRequest.where(requester_id: u.id, receiver_id: new_user.id).first_or_create do |request|
        request.requester_id = u.id
        request.receiver_id = new_user.id
        request.status = "pending"
      end
    end

    UserMailer.with(user: new_user).welcome_email.deliver_later

    new_user
  end

  has_many :posts
  has_one :profile

  has_many :friend_requests_as_requester, foreign_key: :requester_id, class_name: "FriendRequest"
  has_many :requested, through: :friend_requests_as_requester
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: "FriendRequest"
  has_many :received, through: :friend_requests_as_receiver

  def requestStatus(user)
    request = self.friend_requests_as_requester.find{|request| request.receiver_id == user.id}
    receive = self.friend_requests_as_receiver.find{|receive| receive.requester_id == user.id}
    
    return request.status unless request.nil?
    return receive.status unless receive.nil?

    return "none"
  end
end
