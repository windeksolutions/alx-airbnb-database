# Airbnb Database Normalization to Third Normal Form (3NF)

## 1. Original Schema Review

* **User** (`user_id` PK, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`)
* **Property** (`property_id` PK, `host_id` FK, `name`, `description`, `location`, `price_per_night`, `created_at`, `updated_at`)
* **Booking** (`booking_id` PK, `property_id` FK, `user_id` FK, `start_date`, `end_date`, `total_price`, `status`, `created_at`)
* **Payment** (`payment_id` PK, `booking_id` FK, `amount`, `payment_date`, `payment_method`)
* **Review** (`review_id` PK, `property_id` FK, `user_id` FK, `rating`, `comment`, `created_at`)
* **Message** (`message_id` PK, `sender_id` FK, `recipient_id` FK, `message_body`, `sent_at`)

## 2. Normalization Steps

### 2.1 First Normal Form (1NF)

* **Goal:** Eliminate repeating groups and ensure atomicity.
* **Action:** Verify each table has only indivisible (atomic) attributes.
* **Result:** All entities use single-valued, atomic columns—no change needed.

### 2.2 Second Normal Form (2NF)

* **Goal:** Eliminate partial dependencies (only relevant for composite PKs).
* **Action:** Check for composite keys; our schema uses single-column primary keys.
* **Result:** No partial dependencies; all tables satisfy 2NF.

### 2.3 Third Normal Form (3NF)

* **Goal:** Eliminate transitive dependencies—non-key attributes depending on other non-key attributes.
* **Action & Verification**:

  * **User:** All fields (`first_name`, `last_name`, etc.) depend solely on `user_id`.
  * **Property:** Attributes (`name`, `price_per_night`, etc.) depend only on `property_id`; `host_id` is a foreign key.
  * **Booking:** All attributes depend on `booking_id`.
  * **Payment:** Attributes depend only on `payment_id`.
  * **Review:** Attributes depend only on `review_id`.
  * **Message:** Attributes depend only on `message_id`.
* **Result:** No transitive dependencies detected; schema is in 3NF.

## 3. Final 3NF-Compliant Schema (SQL)

```sql
-- 1. User
CREATE TABLE User (
  user_id         UUID PRIMARY KEY,
  first_name      VARCHAR NOT NULL,
  last_name       VARCHAR NOT NULL,
  email           VARCHAR UNIQUE NOT NULL,
  password_hash   VARCHAR NOT NULL,
  phone_number    VARCHAR,
  role            ENUM('guest','host','admin') NOT NULL,
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Property
CREATE TABLE Property (
  property_id     UUID PRIMARY KEY,
  host_id         UUID REFERENCES User(user_id),
  name            VARCHAR NOT NULL,
  description     TEXT NOT NULL,
  location        VARCHAR NOT NULL,
  price_per_night DECIMAL NOT NULL,
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Booking
CREATE TABLE Booking (
  booking_id      UUID PRIMARY KEY,
  property_id     UUID REFERENCES Property(property_id),
  user_id         UUID REFERENCES User(user_id),
  start_date      DATE NOT NULL,
  end_date        DATE NOT NULL,
  total_price     DECIMAL NOT NULL,
  status          ENUM('pending','confirmed','canceled') NOT NULL,
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Payment
CREATE TABLE Payment (
  payment_id      UUID PRIMARY KEY,
  booking_id      UUID REFERENCES Booking(booking_id),
  amount          DECIMAL NOT NULL,
  payment_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method  ENUM('credit_card','paypal','stripe') NOT NULL
);

-- 5. Review
CREATE TABLE Review (
  review_id       UUID PRIMARY KEY,
  property_id     UUID REFERENCES Property(property_id),
  user_id         UUID REFERENCES User(user_id),
  rating          INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
  comment         TEXT NOT NULL,
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Message
CREATE TABLE Message (
  message_id      UUID PRIMARY KEY,
  sender_id       UUID REFERENCES User(user_id),
  recipient_id    UUID REFERENCES User(user_id),
  message_body    TEXT NOT NULL,
  sent_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

*All tables now adhere to 3NF, ensuring no redundant or transitive attribute dependencies.*

