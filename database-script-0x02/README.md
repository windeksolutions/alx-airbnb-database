SQL Sample Data Insertion Task
Overview
This task involves populating the database with realistic sample data using SQL INSERT statements. The data covers all major entities such as User, Property, Booking, Payment, and others, to simulate real-world usage scenarios.

Objectives
Insert representative sample records into each table:

Users with unique attributes

Properties listed by users

Bookings made by users for different properties

Payments corresponding to completed bookings

Ensure data integrity and consistency with the defined schema.

Reflect realistic relationships and interactions between entities.

Deliverables
SQL script file (sample data.sql) containing all INSERT statements.

Each entity should include multiple records to allow for meaningful testing and queries.

Notes
Ensure that foreign key relationships are respected (e.g., bookings reference existing users and properties).

Use a variety of values (e.g., different locations, dates, prices) to simulate real-life application behavior.

Validate the script by running it on the database to confirm successful inserts without constraint violations.
