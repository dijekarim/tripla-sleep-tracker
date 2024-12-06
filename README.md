# **Good Night Tracker API**

A RESTful API that allows users to track their sleep times and follow other users to view their sleep records. Built with Ruby on Rails, PostgreSQL, Sidekiq, and Redis.

---

## **Features**

1. **Clock In/Out:**
   - Users can clock in and out to record their sleep sessions.
   - Retrieve all clocked-in times ordered by creation time.

2. **Follow/Unfollow:**
   - Users can follow or unfollow other users.

3. **Sleep Records of Followees:**
   - View the sleep records of all followees from the previous week.
   - Sleep records are sorted by sleep duration.

4. **Sidekiq Integration:**
   - Sidekiq handles background job processing to improve performance for sleep data calculations.

---

## **Tech Stack**

- **Docker**: Containerized services.
- **Ruby on Rails**: API backend framework.
- **PostgreSQL**: Database for persisting user and sleep data.
- **Redis**: In-memory data store for caching and background job queues.
- **Sidekiq**: Background job processor.
- **RSpec**: Testing framework for API endpoints and background jobs.

---

## **Getting Started**

### **Prerequisites**
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (>= 3.0)
- [Rails](https://guides.rubyonrails.org/getting_started.html) (>= 7.0)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Redis](https://redis.io/docs/getting-started/)
- [Sidekiq](https://github.com/mperham/sidekiq)

---

## **Setup**
### **Running Locally with Docker Compose**

This repository includes a `docker-compose.yml` file to simplify running the application locally with all dependencies (PostgreSQL, Redis, Sidekiq).

#### **Steps**

1. Clone the repository:
   ```bash
   git clone https://github.com/dijekarim/tripla-sleep-tracker.git
   cd tripla-sleep-tracker
   ```

2. **Build and Start Services:**
   Run the following command to build the application and start the services:
   ```bash
   docker compose up --build
   ```

3. **Access the Application:**
   - Rails server will be available at [http://localhost:4000](http://localhost:4000).
   - Sidekiq dashboard (if enabled) will be available at [http://localhost:4000/sidekiq](http://localhost:4000/sidekiq).

4. **Run Migrations:**
   After the containers are up, run database migrations inside the `app` container:
   ```bash
   docker compose exec app rails db:create db:migrate
   ```

5. **Seed Data (Optional):**
   If you want to load seed data:
   ```bash
   docker compose exec app rails db:seed
   ```

---

### **Docker Compose Overview**

The `docker-compose.yml` file sets up the following services:

- **`app`**: The Rails application running with Puma.
- **`db`**: PostgreSQL database.
- **`redis`**: Redis instance for Sidekiq.
- **`sidekiq`**: Background job processor.

---

### **Stopping Services**

To stop the containers, run:
```bash
docker compose down
```

To remove all containers, volumes, and networks (useful for a fresh start):
```bash
docker compose down --volumes --remove-orphans
```

---

### **Accessing Services**

- **Redis**:
  Redis is available internally to the app at `redis://redis:6379/0`.

- **PostgreSQL**:
  PostgreSQL is available internally to the app at `postgres://postgres:password@db:5432`.

---

### **Modifying the Application**

If you make code changes locally, restart the `app` service to see the changes:
```bash
docker compose restart app
```
---

### **API Endpoints**

#### **1. Authentication**

- **Authorization**: For simplicity just fill the `Authorization` Header with `user_id` it can be use jwt for the future improve

#### **2. Clock In/Out**

- **GET `/api/v1/sleep_records`**: Retrieve all user's sleep records

- **POST `/api/v1/sleep_records/clock_in`**: Records the user's clock-in time.

- **POST `/api/v1/sleep_records/clock_out`**: Records the user's clock-out time.

#### **3. Follow/Unfollow**

- **POST `/api/v1/follows`**: Follow another user with payload/body json
  ```json
  {
    "user_id": 1,
  }
  ```

- **DELETE `/api/v1/follows/:user_id`**: Unfollow a user.

#### **4. Sleep Records of Followees**

- **GET `/api/v1/sleep_records/followees_sleep_records`**:
  Retrieve sleep records of all followees from the last week, sorted by sleep duration.

---

### **Running Tests**

1. Run all tests:
   ```bash
   docker compose exec app RAILS_ENV=test rspec
   ```

2. Run specific test files:
   ```bash
   docker compose exec app RAILS_ENV=test rspec spec/requests/api/v1/sleep_records_spec.rb
   ```

---

## **Contributing**

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/name`.
3. Make your changes and commit them: `git commit -m 'feat: Add new feature'`.
4. Push to the branch: `git push origin feature-name`.
5. Submit a pull request.

---

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## **Acknowledgments**

- [Docker](https://docker.com)
- [Ruby on Rails](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Sidekiq](https://sidekiq.org/)
- [Redis](https://redis.io/)
- [RSpec](https://rspec.info/)