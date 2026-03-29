-- +goose Up
-- +goose StatementBegin
ALTER TABLE transaction_type ADD COLUMN description VARCHAR(100);

UPDATE transaction_type SET description = 'Income'          WHERE label = 'income';
UPDATE transaction_type SET description = 'Expense'         WHERE label = 'expense';
UPDATE transaction_type SET description = 'Transfer'        WHERE label = 'transfer';
UPDATE transaction_type SET description = 'Initial Balance' WHERE label = 'initial_balance';

ALTER TABLE transaction_type ALTER COLUMN description SET NOT NULL;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE transaction_type DROP COLUMN description;
-- +goose StatementEnd
