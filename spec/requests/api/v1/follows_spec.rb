require 'rails_helper'

RSpec.describe "Api::V1::Follows", type: :request do
  before(:all) do
    @user = create(:user)
    @other_user = create(:user)
    @new_follow = create(:user)
    @follow = @user.follows.create!(user: @other_user)
  end

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/follows", headers: { "Authorization": @user.id.to_s }
      expect(response).to have_http_status(:success)
      response_json = JSON.parse(response.body)
      expect(response_json.size).to eq(1)
      expect(response_json[0]['user_id']).to eq(@other_user.id)
    end
  end

  describe "POST /create" do
    it "returns http success and followed user" do
      post "/api/v1/follows", params: { user_id: @new_follow.id }, headers: { "Authorization": @user.id.to_s }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['user_id']).to eq(@new_follow.id)
    end

    it "returns http unprocessable entity" do
      post "/api/v1/follows", params: { user_id: @other_user.id }, headers: { "Authorization": @user.id.to_s }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['error']).to eq("You are already following this user")
    end
  end

  describe "DELETE /destroy" do
    it "returns http no content" do
      delete "/api/v1/follows/#{@other_user.id}", headers: { "Authorization": @user.id.to_s }
      expect(response).to have_http_status(:no_content)
    end
  end
end
