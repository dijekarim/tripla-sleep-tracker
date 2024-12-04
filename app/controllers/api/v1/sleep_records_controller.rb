class Api::V1::SleepRecordsController < ApplicationController
  def clock_in
    record = current_user.sleep_records.create!(clock_in: Time.current)
    render json: record, status: :created
  end

  def clock_out
    record = current_user.sleep_records.find_by(clock_out: nil)
    record.update!(clock_out: Time.current)
    render json: record, status: :ok
  end

  def index
    records = current_user.sleep_records.order(created_at: :desc)
    render json: records, status: :ok
  end

  def followees_sleep_records
    sleep_records = SleepRecord.joins(:user)
                               .where(user_id: current_user.followees.pluck(:id))
                               .where('clock_in >= ?', 1.week.ago)
                               .select('sleep_records.id, users.name, EXTRACT(EPOCH FROM clock_out - clock_in) as sleep_duration')
                               .order(Arel.sql('sleep_duration DESC'))
    render json: sleep_records, status: :ok
  end
end
