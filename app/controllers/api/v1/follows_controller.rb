class Api::V1::FollowsController < ApplicationController

  def index
    follows = current_user.follows
    render json: follows.as_json(
      include: {
        user: {
          only: :name
        }
      }, 
      only: [:id, :user_id]
    ), status: :ok
  end
  
  def create
    follow = current_user.follows.create!(user_id: params[:user_id])
    render json: follow, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: {error: 'You are already following this user'}, status: :unprocessable_entity
  end

  def destroy
    follow = current_user.follows.find_by!(user_id: params[:id])
    follow.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
