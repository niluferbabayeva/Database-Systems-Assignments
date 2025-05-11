# Database-Systems-Assignments
During Fall 2024 we had done several assignments covering different concepts from Database Systems. We worked with **PostgreSQL in pgAdmin4**. We had 3 projects:

•	**Normalization** – I were given unnormalized data and asked to normalize it in order to organize the data efficiently by removing redundancy and ensuring data integrity. This was achieved by systematically applying the principles of **First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF)**. Additionally, I **created Entity-Relationship (ER) diagrams** at each stage—**for the unnormalized data, as well as after applying 1NF, 2NF, and 3NF**—to visually represent the evolving structure and relationships between entities.

•	**Implementation of Normalization in PostgreSQL**- I basically needed to do transform data to Normalized form in PostgreSQL  **(finalversion.sql)**. There, I didn’t manually add all the values. Instead, first I changed the file to **CSV** and then imported it to pgAdmin4 which facilitated my workload. You can review my code called **finalversion.sql** where I correctly display each table using SQL.

•	**Optimization**- The last assignment was about optimizing the given code so that we can save time and memory. What I did first was analyzing the code using **EXPLAIN ANALYZE** to get more detail (how the query was executed (sequential scan, index scan, etc.), actual runtime, how long each step took, etc.). Then using **Indexes** which make data retrieval faster, I achieved optimization (e.g., runtime of the query was less, took less memory)

