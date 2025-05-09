# 🏠 Airbnb Database Design

## ✅ Entities and Their Attributes

### 1. **User**
- **Primary Key:** `user_id`
- **Attributes:**
  - `first_name`
  - `last_name`
  - `email` (unique)
  - `password_hash`
  - `phone_number` (nullable)
  - `role` (ENUM: guest, host, admin)
  - `created_at`

---

### 2. **Property**
- **Primary Key:** `property_id`
- **Foreign Key:** `host_id` → `User.user_id`
- **Attributes:**
  - `name`
  - `description`
  - `location`
  - `pricepernight`
  - `created_at`
  - `updated_at`

---

### 3. **Booking**
- **Primary Key:** `booking_id`
- **Foreign Keys:**
  - `property_id` → `Property.property_id`
  - `user_id` → `User.user_id`
- **Attributes:**
  - `start_date`
  - `end_date`
  - `total_price`
  - `status` (ENUM: pending, confirmed, canceled)
  - `created_at`

---

### 4. **Payment**
- **Primary Key:** `payment_id`
- **Foreign Key:** `booking_id` → `Booking.booking_id`
- **Attributes:**
  - `amount`
  - `payment_date`
  - `payment_method` (ENUM: credit_card, paypal, stripe)

---

### 5. **Review**
- **Primary Key:** `review_id`
- **Foreign Keys:**
  - `property_id` → `Property.property_id`
  - `user_id` → `User.user_id`
- **Attributes:**
  - `rating` (1 to 5)
  - `comment`
  - `created_at`

---

### 6. **Message**
- **Primary Key:** `message_id`
- **Foreign Keys:**
  - `sender_id` → `User.user_id`
  - `recipient_id` → `User.user_id`
- **Attributes:**
  - `message_body`
  - `sent_at`

---

## 🔁 Relationships Between Entities

| From Entity | To Entity     | Relationship Type      | Description                                      |
|-------------|---------------|-------------------------|--------------------------------------------------|
| **User**    | **Property**  | One-to-Many             | A user (as a host) can list multiple properties  |
| **User**    | **Booking**   | One-to-Many             | A user (as a guest) can book multiple properties |
| **Property**| **Booking**   | One-to-Many             | A property can have multiple bookings            |
| **Booking** | **Payment**   | One-to-One / One-to-Many| Each booking has at least one payment            |
| **User**    | **Review**    | One-to-Many             | A user can leave multiple reviews                |
| **Property**| **Review**    | One-to-Many             | A property can receive many reviews              |
| **User**    | **User**      | Many-to-Many (via Message) | Users can message each other                |


## 🔗 Entity Relationships (Markdown Format)

- **User (host)** → **Property**  
  A host can list multiple properties.

- **User (guest)** → **Booking**  
  A guest can make multiple bookings.

- **Property** → **Booking**  
  Each property can be booked multiple times.

- **Booking** → **Payment**  
  Each booking has at least one payment.

- **User** → **Review**  
  A user can leave multiple reviews.

- **Property** → **Review**  
  A property can have many reviews.

- **User** ↔ **User** *(via Message: sender and recipient)*  
  Users can message each other.

