# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :authenticate_user!

  attr_reader :current_user

  private

  def authenticate_user!
    token = request.headers['Authorization']
    unless token
      render json: { error: 'Unauthorized' }, status: :unauthorized and return
    end

    begin
      # Assuming the token is the user's ID for simplicity; in a real app, use JWT or similar
      @current_user = User.find(token)
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
