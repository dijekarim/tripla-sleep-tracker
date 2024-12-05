require 'redis'

REDIS = Redis.new(
  url: ENV.fetch('CACHE_URL', 'redis://localhost:6379/0')
)
