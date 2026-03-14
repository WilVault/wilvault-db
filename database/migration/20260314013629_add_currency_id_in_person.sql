-- +goose Up
-- +goose StatementBegin
ALTER TABLE person
    ADD COLUMN currency_id INT NULL;
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
ALTER TABLE person
    DROP COLUMN IF EXISTS currency_id;
-- +goose StatementEnd