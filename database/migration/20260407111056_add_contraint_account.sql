-- +goose Up
-- +goose StatementBegin
ALTER TABLE account
    DROP CONSTRAINT IF EXISTS account_person_id_fkey,
    ADD CONSTRAINT account_person_id_fkey
        FOREIGN KEY (person_id)
        REFERENCES person (id)
        ON DELETE CASCADE;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE account
    DROP CONSTRAINT IF EXISTS account_person_id_fkey,
    ADD CONSTRAINT account_person_id_fkey
        FOREIGN KEY (person_id)
        REFERENCES person (id);
        -- No ON DELETE CASCADE (default is NO ACTION / RESTRICT)
-- +goose StatementEnd