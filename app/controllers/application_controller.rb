class ApplicationController < ActionController::Base
  before_action :authenticate_user!


  def friend_request_id(friend)
    FriendRequest.where(
      "(requestor_id = ? AND receiver_id = ?) OR (requestor_id = ? AND receiver_id = ?)",
      current_user.id, friend.id, friend.id, current_user.id
    ).pluck(:id).first
  end
  
end
