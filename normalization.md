##First Normal Form (1NF) Analysis
 The schema is in 1NF.
##Second Normal Form (2NF) Analysis
The schema is in 2NF since there are no composite keys or partial dependencies.
##Third Normal Form (3NF) Analysis
The total_price attribute in the Booking table is a derived attribute, introducing a transitive dependency. Storing it risks redundancy and anomalies (e.g., if pricepernight changes, total_price may become inconsistent).
To achieve 3NF, the total_price attribute is removed from the Booking table. Instead, it can be calculated dynamically using a query:



####Final Schema in 3NF
User: Unchanged
Property: Unchanged.
Booking: Removed total_price to eliminate transitive dependency.
Payment: Unchanged.
Review: Unchanged.
Message: Unchanged.
