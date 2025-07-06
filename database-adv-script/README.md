SQL Joins Documentation
This directory contains SQL queries demonstrating the use of different join types for the Airbnb Clone database, designed to meet ALX project requirements. The queries are based on the schema defined for the alx-airbnb-database repository and support complex data retrieval operations.
Contents

complex-queries.sql: Includes three SQL queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN to retrieve data from the database.

Query Overview

INNER JOIN Query: Retrieves all bookings and the respective users who made them, matching only where both records exist.
LEFT JOIN Query: Retrieves all properties and their reviews, including properties with no reviews (NULL values where applicable).
FULL OUTER JOIN Query: Retrieves all users and all bookings, showing all records even if a user has no booking or a booking lacks a user.

Schema Context
The queries operate on the following tables:

User: user_id (UUID, PK), first_name (VARCHAR), last_name (VARCHAR), email (VARCHAR, UNIQUE), password_hash (VARCHAR), phone_number (VARCHAR, NULL), role (ENUM), created_at (TIMESTAMP).
Property: property_id (UUID, PK), host_id (FK to User), name (VARCHAR), description (TEXT), location (VARCHAR), pricepernight (DECIMAL), created_at (TIMESTAMP), updated_at (TIMESTAMP).
Booking: booking_id (UUID, PK), property_id (FK to Property), user_id (FK to User), start_date (DATE), end_date (DATE), total_price (DECIMAL), status (ENUM), created_at (TIMESTAMP).
Review: review_id (UUID, PK), property_id (FK to Property), user_id (FK to User), rating (INTEGER, 1-5), comment (TEXT), created_at (TIMESTAMP).

Usage

Run the queries in a SQL environment (e.g., PostgreSQL) compatible with the schema from the alx-airbnb-database repository.
Ensure the database includes the User, Property, Booking, and Review tables with the specified columns and constraints.
Adjust query column selections or joins if the schema evolves (e.g., adding Payment or Message tables).

Project Context
These queries support the Airbnb Clone’s backend development by enabling complex data retrieval for features like user management, property listings, and booking tracking. They align with the requirements in requirements.md, the data flow diagram in data-flow-diagram/, and the flowcharts in flowcharts/.
Created on July 06, 2025
