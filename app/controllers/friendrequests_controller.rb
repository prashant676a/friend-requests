class FriendrequestsController < ApplicationController
  def index

    @requested_requests = FriendRequest.where(requestor_id: current_user.id).where.not(status: "accepted")
    @received_requests = FriendRequest.where(receiver_id: current_user.id).where.not(status: "accepted")    
    
    @friends=[]
    FriendRequest.where(status: 'accepted').map do |request|

      if request.requestor_id == current_user.id 
        @friends.push(request.receiver) 
      elsif request.receiver_id == current_user.id
        @friends.push(request.requestor)
      end
    end

    @related = []
    @related += FriendRequest.where(requestor_id: current_user.id).map{|request| request.receiver_id } 
    @related += FriendRequest.where(receiver_id: current_user.id).map{|request| request.requestor_id }
    
    @not_related = User.where.not(id: @related).where.not(id:current_user.id)
  end

  def create
    @friendrequest = FriendRequest.new(friendrequest_params)
    @friendrequest.status = 'pending'

    if @friendrequest.save
      redirect_to root_path
    end
  end

  def update
    @request = FriendRequest.find(params[:id])

    if @request.update(status: 'accepted') 
      redirect_to root_path, message: "updated successfully."
    end

  end

  def destroy
    @friendrequest = FriendRequest.find(params[:id])
    @friendrequest.destroy

    redirect_to root_path
  end

  
  

  private

  def friendrequest_params
    params.require(:friend_request).permit(:requestor_id, :receiver_id, :status)
  end
end
