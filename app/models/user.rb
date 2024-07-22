class User < ApplicationRecord
  has_many :friend_requests_as_requestor, foreign_key: :requestor_id,\
    class_name: :FriendRequest
  
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, \
    class_name: :FriendRequest

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
