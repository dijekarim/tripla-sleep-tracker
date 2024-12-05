class Api::V1::SleepRecordsController < ApplicationController
  def clock_in
    record = current_user.sleep_records.create!(clock_in: Time.current)
    render json: record, status: :created
  end

  def clock_out
    record = current_user.sleep_records.find_by(clock_out: nil)
    record.update!(clock_out: Time.current)
    # Trigger background job to update followers' sleep data
    UpdateFollowersSleepDataJob.perform_async(current_user.id)
    render json: record, status: :ok
  end

  def index
    records = current_user.sleep_records.order(created_at: :desc)
    render json: records, status: :ok
  end

  def followees_sleep_records
    redis_key = "user:#{current_user.id}:sleep_data"
    cached_data = REDIS.get(redis_key)

    if cached_data.present?
      result = JSON.parse(cached_data)
      result.each do |record|
        duration = record['duration'].to_f
        record['duration_in_time'] = format_duration(duration)
      end
      render json: result, status: :ok
    else
      # Optionally trigger a job to populate cache if empty
      UpdateFollowersSleepDataJob.perform_async(current_user.id)
      render json: { message: "Data is being prepared. Try again shortly." }, status: :accepted
    end
  end

  private
  def format_duration(seconds)
    total_milliseconds = (seconds * 1000).to_i
    milliseconds = total_milliseconds % 1000
    total_seconds = total_milliseconds / 1000
    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60
  
    format('%02d:%02d:%02d.%03d', hours, minutes, seconds, milliseconds)
  end
end
