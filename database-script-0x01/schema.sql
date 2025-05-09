-- 1. Users
CREATE TABLE users (
  user_id        UUID           PRIMARY KEY,
  first_name     VARCHAR(100)   NOT NULL,
  last_name      VARCHAR(100)   NOT NULL,
  email          VARCHAR(255)   NOT NULL UNIQUE,
  password_hash  VARCHAR(255)   NOT NULL,
  phone_number   VARCHAR(20),
  role           ENUM('guest','host','admin') NOT NULL,
  created_at     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Index on email for fast lookups (unique already creates an index)
CREATE INDEX idx_users_email ON users(email);


-- 2. Properties
CREATE TABLE properties (
  property_id       UUID           PRIMARY KEY,
  host_id           UUID           NOT NULL,
  name              VARCHAR(200)   NOT NULL,
  description       TEXT           NOT NULL,
  location          VARCHAR(255)   NOT NULL,
  price_per_night   DECIMAL(10,2)  NOT NULL,
  created_at        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_properties_host
    FOREIGN KEY (host_id) REFERENCES users(user_id)
);

-- Index on host_id for host → properties joins
CREATE INDEX idx_properties_host_id ON properties(host_id);


-- 3. Bookings
CREATE TABLE bookings (
  booking_id   UUID           PRIMARY KEY,
  property_id  UUID           NOT NULL,
  user_id      UUID           NOT NULL,
  start_date   DATE           NOT NULL,
  end_date     DATE           NOT NULL,
  total_price  DECIMAL(10,2)  NOT NULL,
  status       ENUM('pending','confirmed','canceled') NOT NULL,
  created_at   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_bookings_property
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
  CONSTRAINT fk_bookings_user
    FOREIGN KEY (user_id)     REFERENCES users(user_id)
);

-- Indexes on foreign keys and status
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_user_id     ON bookings(user_id);
CREATE INDEX idx_bookings_status      ON bookings(status);


-- 4. Payments
CREATE TABLE payments (
  payment_id      UUID           PRIMARY KEY,
  booking_id      UUID           NOT NULL,
  amount          DECIMAL(10,2)  NOT NULL,
  payment_date    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  payment_method  ENUM('credit_card','paypal','stripe') NOT NULL,
  CONSTRAINT fk_payments_booking
    FOREIGN KEY (booking_id)   REFERENCES bookings(booking_id)
);

-- Index on booking_id for payment lookups
CREATE INDEX idx_payments_booking_id ON payments(booking_id);


-- 5. Reviews
CREATE TABLE reviews (
  review_id    UUID           PRIMARY KEY,
  property_id  UUID           NOT NULL,
  user_id      UUID           NOT NULL,
  rating       INT            NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment      TEXT           NOT NULL,
  created_at   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_reviews_property
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
  CONSTRAINT fk_reviews_user
    FOREIGN KEY (user_id)     REFERENCES users(user_id)
);

-- Indexes on foreign keys
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id     ON reviews(user_id);


-- 6. Messages
CREATE TABLE messages (
  message_id    UUID      PRIMARY KEY,
  sender_id     UUID      NOT NULL,
  recipient_id  UUID      NOT NULL,
  message_body  TEXT      NOT NULL,
  sent_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_messages_sender
    FOREIGN KEY (sender_id)    REFERENCES users(user_id),
  CONSTRAINT fk_messages_recipient
    FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);

-- Indexes on sender and recipient for message queries
CREATE INDEX idx_messages_sender_id    ON messages(sender_id);
CREATE INDEX idx_messages_recipient_id ON messages(recipient_id);

