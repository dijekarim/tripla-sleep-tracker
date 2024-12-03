# Use official Ruby image
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set environment variables
ENV RAILS_ENV=development
ENV REDIS_URL=redis://redis:6379/0

# Set the working directory
WORKDIR /app

# Install dependencies
COPY Gemfile* ./
RUN bundle install

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Command to run the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
