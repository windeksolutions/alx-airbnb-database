-- ##################################################
-- # Sample Data Inserts (OWASP, PCI-DSS, GDPR Compliant)
-- ##################################################

-- 1. Prepare Parameterized Statements

-- 1.1 Users
PREPARE insert_user(
  uuid, varchar, varchar, varchar, varchar, varchar, varchar
) AS
INSERT INTO users (
  user_id, first_name, last_name, email, password_hash, phone_number, role
) VALUES (
  $1, $2, $3, $4, $5, $6, $7
);

-- 1.2 Properties
PREPARE insert_property(
  uuid, uuid, varchar, text, varchar, numeric
) AS
INSERT INTO properties (
  property_id, host_id, name, description, location, price_per_night
) VALUES (
  $1, $2, $3, $4, $5, $6
);

-- 1.3 Bookings
PREPARE insert_booking(
  uuid, uuid, uuid, date, date, numeric, varchar
) AS
INSERT INTO bookings (
  booking_id, property_id, user_id, start_date, end_date, total_price, status
) VALUES (
  $1, $2, $3, $4, $5, $6, $7
);

-- 1.4 Payments
PREPARE insert_payment(
  uuid, uuid, numeric, varchar
) AS
INSERT INTO payments (
  payment_id, booking_id, amount, payment_method
) VALUES (
  $1, $2, $3, $4
);

-- 1.5 Reviews
PREPARE insert_review(
  uuid, uuid, uuid, integer, text
) AS
INSERT INTO reviews (
  review_id, property_id, user_id, rating, comment
) VALUES (
  $1, $2, $3, $4, $5
);

-- 1.6 Messages
PREPARE insert_message(
  uuid, uuid, uuid, text
) AS
INSERT INTO messages (
  message_id, sender_id, recipient_id, message_body
) VALUES (
  $1, $2, $3, $4
);

-- 2. Execute with Sample Data

-- 2.1 Users (7 sample users)
EXECUTE insert_user(
  '11111111-1111-1111-1111-111111111111',
  'Alice', 'Anderson',
  'alice.host@example.com',
  '$2b$12$e9oG1Y...XyZ9f',  -- bcrypt hash
  '+15551234567',
  'host'
);
EXECUTE insert_user(
  '22222222-2222-2222-2222-222222222222',
  'Bob', 'Brown',
  'bob.guest@example.com',
  '$2b$12$AbC4D...GhIjK',
  '+15557654321',
  'guest'
);
EXECUTE insert_user(
  '33333333-3333-3333-3333-333333333333',
  'Carol', 'Clark',
  'carol.guest@example.com',
  '$2b$12$LmNoP...QrStU',
  '+15559876543',
  'guest'
);
EXECUTE insert_user(
  '44444444-4444-4444-4444-444444444444',
  'Dana', 'Doe',
  'dana.admin@example.com',
  '$2b$12$VwXyZ...AaBbC',
  NULL,
  'admin'
);
EXECUTE insert_user(
  '55555555-5555-5555-5555-555555555555',
  'Emily', 'Evans',
  'emily.host@example.com',
  '$2b$12$XyZaB...CdEfG',
  '+15553456789',
  'host'
);
EXECUTE insert_user(
  '66666666-6666-6666-6666-666666666666',
  'Frank', 'Foster',
  'frank.guest@example.com',
  '$2b$12$GhIjK...LmNoP',
  '+15559876123',
  'guest'
);
EXECUTE insert_user(
  '77777777-7777-7777-7777-777777777777',
  'Grace', 'Green',
  'grace.guest@example.com',
  '$2b$12$QrStU...VwXyZ',
  '+15552345678',
  'guest'
);

-- 2.2 Properties (4 sample properties)
EXECUTE insert_property(
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  '11111111-1111-1111-1111-111111111111',
  'Cozy Downtown Loft',
  'One-bedroom loft in the city center, walkable to shops.',
  'New York, NY',
  120.00
);
EXECUTE insert_property(
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  '11111111-1111-1111-1111-111111111111',
  'Beachside Bungalow',
  '2BR bungalow with ocean views and private patio.',
  'Miami Beach, FL',
  200.00
);
EXECUTE insert_property(
  'cccccccc-cccc-cccc-cccc-cccccccccccc',
  '55555555-5555-5555-5555-555555555555',
  'Mountain Cabin',
  'Secluded cabin with mountain views and fireplace.',
  'Asheville, NC',
  150.00
);
EXECUTE insert_property(
  'dddddddd-dddd-dddd-dddd-dddddddddddd',
  '55555555-5555-5555-5555-555555555555',
  'Urban Studio',
  'Modern studio apartment in bustling downtown.',
  'Chicago, IL',
  90.00
);

-- 2.3 Bookings (7 sample bookings)
EXECUTE insert_booking(
  'aaaaaaaa-1111-2222-3333-aaaaaaaa1111',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  '22222222-2222-2222-2222-222222222222',
  '2025-06-01',
  '2025-06-05',
  480.00,
  'confirmed'
);
EXECUTE insert_booking(
  'bbbbbbbb-2222-3333-4444-bbbbbbbb2222',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  '33333333-3333-3333-3333-333333333333',
  '2025-07-10',
  '2025-07-15',
  1000.00,
  'pending'
);
EXECUTE insert_booking(
  'cccccccc-3333-4444-5555-cccccccc3333',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  '33333333-3333-3333-3333-333333333333',
  '2025-06-20',
  '2025-06-22',
  240.00,
  'confirmed'
);
EXECUTE insert_booking(
  'dddddddd-4444-5555-6666-dddddddd4444',
  'cccccccc-cccc-cccc-cccc-cccccccccccc',
  '22222222-2222-2222-2222-222222222222',
  '2025-08-01',
  '2025-08-07',
  900.00,
  'confirmed'
);
EXECUTE insert_booking(
  'eeeeeeee-5555-6666-7777-eeeeeeee5555',
  'dddddddd-dddd-dddd-dddd-dddddddddddd',
  '66666666-6666-6666-6666-666666666666',
  '2025-09-10',
  '2025-09-12',
  180.00,
  'cancelled'
);
EXECUTE insert_booking(
  'ffffffff-6666-7777-8888-ffffffff6666',
  'cccccccc-cccc-cccc-cccc-cccccccccccc',
  '77777777-7777-7777-7777-777777777777',
  '2025-10-05',
  '2025-10-10',
  750.00,
  'pending'
);
EXECUTE insert_booking(
  'gggggggg-7777-8888-9999-gggggggg7777',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  '33333333-3333-3333-3333-333333333333',
  '2025-11-15',
  '2025-11-20',
  1000.00,
  'confirmed'
);

-- 2.4 Payments (7 sample payments)
EXECUTE insert_payment(
  'pppppppp-5555-6666-7777-pppppppp5555',
  'aaaaaaaa-1111-2222-3333-aaaaaaaa1111',
  480.00,
  'credit_card'
);
EXECUTE insert_payment(
  'pppppppp-8888-9999-0000-pppppppp8888',
  'bbbbbbbb-2222-3333-4444-bbbbbbbb2222',
  200.00,
  'paypal'
);
EXECUTE insert_payment(
  'qqqqqqqq-1111-2222-3333-qqqqqqqq1111',
  'cccccccc-3333-4444-5555-cccccccc3333',
  240.00,
  'bank_transfer'
);
EXECUTE insert_payment(
  'rrrrrrrr-2222-3333-4444-rrrrrrrr2222',
  'dddddddd-4444-5555-6666-dddddddd4444',
  900.00,
  'credit_card'
);
EXECUTE insert_payment(
  'ssssssss-3333-4444-5555-ssssssss3333',
  'eeeeeeee-5555-6666-7777-eeeeeeee5555',
  180.00,
  'paypal'
);
EXECUTE insert_payment(
  'tttttttt-4444-5555-6666-tttttttt4444',
  'ffffffff-6666-7777-8888-ffffffff6666',
  750.00,
  'apple_pay'
);
EXECUTE insert_payment(
  'uuuuuuuu-5555-6666-7777-uuuuuuuu5555',
  'gggggggg-7777-8888-9999-gggggggg7777',
  1000.00,
  'google_pay'
);

-- 2.5 Reviews (5 sample reviews)
EXECUTE insert_review(
  'rrrrrrrr-1111-2222-3333-rrrrrrrr1111',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  '22222222-2222-2222-2222-222222222222',
  5,
  'Fantastic stay! Loft was clean and cozy.'
);
EXECUTE insert_review(
  'vvvvvvvv-6666-7777-8888-vvvvvvvv6666',
  'cccccccc-cccc-cccc-cccc-cccccccccccc',
  '22222222-2222-2222-2222-222222222222',
  4,
  'Great cabin, lovely fireplace.'
);
EXECUTE insert_review(
  'wwwwwwww-3333-4444-5555-wwwwwwww3333',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  '77777777-7777-7777-7777-777777777777',
  3,
  'Nice view but a bit noisy.'
);
EXECUTE insert_review(
  'xxxxxxxx-4444-5555-6666-xxxxxxxx4444',
  'dddddddd-dddd-dddd-dddd-dddddddddddd',
  '66666666-6666-6666-6666-666666666666',
  5,
  'Perfect studio for a weekend in Chicago.'
);
EXECUTE insert_review(
  'yyyyyyyy-5555-6666-7777-yyyyyyyy5555',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  '33333333-3333-3333-3333-333333333333',
  4,
  'Close to everything, would visit again.'
);

-- 2.6 Messages (7 sample messages)
EXECUTE insert_message(
  'mmmmmmmm-1111-2222-3333-mmmmmmmm1111',
  '22222222-2222-2222-2222-222222222222',
  '11111111-1111-1111-1111-111111111111',
  'Hi Alice, is early check-in at 12 PM possible?'
);
EXECUTE insert_message(
  'mmmmmmmm-4444-5555-6666-mmmmmmmm4444',
  '11111111-1111-1111-1111-111111111111',
  '22222222-2222-2222-2222-222222222222',
  'Yes, early check-in at 12 PM works for me. See you then.'
);
EXECUTE insert_message(
  'zzzzzzzz-1111-2222-3333-zzzzzzzz1111',
  '33333333-3333-3333-3333-333333333333',
  '11111111-1111-1111-1111-111111111111',
  'Can you provide extra towels on arrival?'
);
EXECUTE insert_message(
  'zzzzzzzz-4444-5555-6666-zzzzzzzz4444',
  '11111111-1111-1111-1111-111111111111',
  '33333333-3333-3333-3333-333333333333',
  'Sure! I will have extra towels ready.'
);
EXECUTE insert_message(
  'aaaaaaa1-7777-8888-9999-aaaaaaa17777',
  '66666666-6666-6666-6666-666666666666',
  '55555555-5555-5555-5555-555555555555',
  'Is parking available on-site?'
);
EXECUTE insert_message(
  'bbbbbbb2-1111-2222-3333-bbbbbbb21111',
  '55555555-5555-5555-5555-555555555555',
  '66666666-6666-6666-6666-666666666666',
  'Yes, there is free parking behind the studio.'
);
EXECUTE insert_message(
  'ccccccc3-4444-5555-6666-ccccccc34444',
  '77777777-7777-7777-7777-777777777777',
  '11111111-1111-1111-1111-111111111111',
  'Thank you! Looking forward to my stay.'
);

