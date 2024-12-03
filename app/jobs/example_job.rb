class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info("Running Sidekiq Job with args: #{args}")
  end
end
