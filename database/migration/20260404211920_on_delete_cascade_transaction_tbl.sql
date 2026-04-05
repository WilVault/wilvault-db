-- +goose Up
-- +goose StatementBegin
ALTER TABLE transaction
    DROP CONSTRAINT transaction_account_id_fkey,
    ADD CONSTRAINT transaction_account_id_fkey
        FOREIGN KEY (account_id)
        REFERENCES account (id)
        ON DELETE CASCADE;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE transaction
    DROP CONSTRAINT transaction_account_id_fkey,
    ADD CONSTRAINT transaction_account_id_fkey
        FOREIGN KEY (account_id)
        REFERENCES account (id);
-- +goose StatementEnd
