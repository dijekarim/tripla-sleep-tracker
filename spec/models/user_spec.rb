require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'has a name' do
    expect(user.name).to eq('Example User')
  end
end
