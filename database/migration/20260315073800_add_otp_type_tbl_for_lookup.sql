-- +goose Up
-- +goose StatementBegin
CREATE TABLE otp_type (
    id    SERIAL PRIMARY KEY,
    label VARCHAR NOT NULL UNIQUE
);

INSERT INTO otp_type (label) VALUES
    ('Register'),
    ('Forgot Your Password'),
    ('Change Your Password');
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS otp_type;
-- +goose StatementEnd