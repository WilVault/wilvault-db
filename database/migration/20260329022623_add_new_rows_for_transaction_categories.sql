-- +goose Up
-- +goose StatementBegin
INSERT INTO transaction_categories (label, icon) VALUES
    ('Salary', '💼'),
    ('Income', '💰');
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM transaction_categories WHERE label IN ('Salary', 'Income');
-- +goose StatementEnd
