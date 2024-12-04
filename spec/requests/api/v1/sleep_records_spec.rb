require 'rails_helper'

RSpec.describe "Api::V1::SleepRecordsController", type: :request do
  before(:all) do
    @user = create(:user)
    @followed_user = create(:user)
    @user.follows.create!(user: @followed_user)
    @record = create(:sleep_record, user: @followed_user, clock_in: 8.hours.ago)
  end

  describe "POST #clock_in" do
    it "clock_ins a sleep record for the current user" do
      post '/api/v1/sleep_records/clock_in', headers: { 'Authorization' => @followed_user.id.to_s }
      expect(response).to have_http_status(:created)
      expect(@record.user).to eq(@followed_user)
    end
  end

  describe "POST #clock_out" do
    it "clock_outs a sleep record for the current user" do
      post "/api/v1/sleep_records/clock_out", headers: { 'Authorization' => @followed_user.id.to_s }
      expect(response).to have_http_status(:ok)
      expect(@record.user).to eq(@followed_user)
    end
  end

  describe "GET #followees_sleep_records" do
    it "returns sleep records of followed users from the last week" do
      get '/api/v1/sleep_records/followees_sleep_records', headers: { 'Authorization' => @user.id.to_s }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end