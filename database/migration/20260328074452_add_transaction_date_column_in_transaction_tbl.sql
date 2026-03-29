-- +goose Up
-- +goose StatementBegin
ALTER TABLE transaction ADD COLUMN transaction_date DATE NOT NULL DEFAULT CURRENT_DATE;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE transaction DROP COLUMN transaction_date;
-- +goose StatementEnd
