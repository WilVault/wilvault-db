-- +goose Up
-- +goose StatementBegin
CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    email VARCHAR NOT NULL,
    full_name VARCHAR NOT NULL,
    password_hash VARCHAR NULL,
    profile_url VARCHAR,
    profile_url_customized BOOLEAN DEFAULT FALSE,
    timezone VARCHAR,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS person
-- +goose StatementEnd