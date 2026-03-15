-- +goose Up
-- +goose StatementBegin
CREATE TABLE otp (
    id            SERIAL PRIMARY KEY,
    email         VARCHAR,
    otp_type_id   INT REFERENCES otp_type(id),
    created_at    TIMESTAMP,
    expiration_at TIMESTAMP,
    timezone      VARCHAR
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS otp;
-- +goose StatementEnd