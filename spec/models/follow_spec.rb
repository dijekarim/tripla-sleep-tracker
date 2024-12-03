require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:follow) { create(:follow, user: user, follower: other_user) }

  it 'has a follower' do
    expect(follow.follower).to eq(other_user)
  end

  it 'has a user' do
    expect(follow.user).not_to be_nil
  end

  it 'is unique' do
    expect { create(:follow, follower: user) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is valid' do
    expect(follow).to be_valid
  end
end
