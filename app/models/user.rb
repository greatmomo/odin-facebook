class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid, name: auth.name).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      end
  end

  has_many :posts

  has_many :friend_requests_as_requester, foreign_key: :requester_id, class_name: :FriendRequest
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: :FriendRequest

  # has_many :friend_requests, ->(user) { where("requester_id = ? OR receiver_id = ?", user.id, user.id) }
  # has_many :friends, through: :friend_requests

  def requested?(user)
    !!self.friend_requests_as_requester.find{|request| request.receiver_id == user.id}
  end
end
