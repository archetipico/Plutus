CREATE SCHEMA IF NOT EXISTS plutus_schema;

SET search_path TO plutus_schema;

-- User table
CREATE TABLE IF NOT EXISTS plutus_user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    pwd VARCHAR(128) NOT NULL,
    email VARCHAR(254) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    deleted_at TIMESTAMP,
    CONSTRAINT unique_email UNIQUE (email)
);

-- Transaction category table
-- name         Food
-- description  "Payment to restaurant"
CREATE TABLE IF NOT EXISTS transaction_category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(250) NOT NULL,
    description VARCHAR(250),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    deleted_at TIMESTAMP
);

-- Transaction table
-- user_id_fk       User (Logged user)
-- category_id_fk   Category (e.g. Food)
-- amount       43.20€
-- type         0=out 1=in
-- description  "Restaurant at Central Park"
CREATE TABLE IF NOT EXISTS plutus_transaction (
    id SERIAL PRIMARY KEY,
    user_id_fk SERIAL,
    category_id_fk SERIAL,
    amount NUMERIC(15, 2) NOT NULL,
    type BOOLEAN NOT NULL,
    description VARCHAR(250),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    deleted_at TIMESTAMP,
    FOREIGN KEY (user_id_fk) REFERENCES plutus_user(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (category_id_fk) REFERENCES transaction_category(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

RESET search_path;
