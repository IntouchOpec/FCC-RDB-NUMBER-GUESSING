CREATE DATABASE number_guess;
CREATE TABLE users();
ALTER TABLE users ADD COLUMN username VARCHAR(50) NOT NULL UNIQUE;
ALTER TABLE users ADD COLUMN user_id SERIAL PRIMARY KEY NOT NULL;
