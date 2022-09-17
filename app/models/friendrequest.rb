class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: :User
  belongs_to :receiver, class_name: :User

  # belongs_to :friend_a, class_name: :User
  # belongs_to :friend_b, class_name: :User
end