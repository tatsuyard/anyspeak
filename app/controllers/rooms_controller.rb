# For main page controller
class RoomsController < ApplicationController
  # before_action :require_authentication, without: :index

  def index
    if logged_in?
      @users = User.where.not(id: current_user.id)
    else
      @users = User.none if @users.nil?
    end
  end

  def find_connect_uid
    if logged_in? && params[:user_id]
      connect_uid = User.find(params[:user_id]).connect_uid
      render json: { connect_uid: connect_uid }, status: :ok
    else
      render json: { msg: 'please login' }, status: :ok
    end
  end

  def update_connect_uid
    if logged_in? && params[:connect_uid]
      current_user.update_attributes(
        connect_uid: params[:connect_uid],
        updated_at: Time.now)
    end
    render nothing: true
  end
end
