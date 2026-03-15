-- +goose Up
-- +goose StatementBegin
ALTER TABLE otp ADD COLUMN otp VARCHAR NOT NULL;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE otp DROP COLUMN otp;
-- +goose StatementEnd