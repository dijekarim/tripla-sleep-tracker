require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  let(:user) { create(:user) }
  let(:sleep_record) { create(:sleep_record, user: user) }

  it 'has a clock_in' do
    expect(sleep_record.clock_in).not_to be_nil
  end

  it 'has a clock_out' do
    expect(sleep_record.clock_out).not_to be_nil
  end

  it 'clock_out must be after clock_in' do
    sleep_record.clock_out = sleep_record.clock_in - 1.hour
    expect(sleep_record).not_to be_valid
  end
end
