class UpdateFollowersSleepDataJob
  include Sidekiq::Job
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    one_week_ago = 1.week.ago.beginning_of_day

    # Recompute sleep data for each follower
    user.followers_data.find_each do |follower|
      sleep_records = SleepRecord
                        .joins(:user)
                        .where(user: follower.followees, clock_in: one_week_ago..Time.current)
                        .select("sleep_records.id AS id, users.name AS name, EXTRACT(EPOCH FROM clock_out - clock_in) AS duration, clock_in, clock_out")
                        .order("duration DESC")

      # Store updated data in Redis
      redis_key = "user:#{follower.id}:sleep_data"
      REDIS.set(redis_key, sleep_records.to_json)
      REDIS.expire(redis_key, 8.days) # Expire after 8 days
    end
  end
end
