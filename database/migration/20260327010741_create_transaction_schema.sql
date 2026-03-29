-- +goose Up
-- +goose StatementBegin
CREATE TABLE transaction_type (
    id    SERIAL PRIMARY KEY,
    label VARCHAR(50) NOT NULL
);

INSERT INTO transaction_type (label) VALUES
    ('income'),
    ('expense'),
    ('transfer'),
    ('initial_balance');

CREATE TABLE transaction_categories (
    id    SERIAL PRIMARY KEY,
    label VARCHAR(100) NOT NULL,
    icon  VARCHAR(255)
);

INSERT INTO transaction_categories (label, icon) VALUES
    ('Food',            '🍔'),
    ('Transport',       '🚗'),
    ('Health',          '🏥'),
    ('Entertainment',   '🎬'),
    ('Utilities',       '⚡'),
    ('Shopping',        '🛒'),
    ('Investment',      '📈'),
    ('Others',          '📦'),
    ('Initial Balance', '🏦'),
    ('Transfer',        '↔️');

CREATE TABLE transaction (
    id                      SERIAL PRIMARY KEY,
    account_id              INT             NOT NULL REFERENCES account (id),
    transaction_category_id INT             NOT NULL REFERENCES transaction_categories (id),
    transaction_type_id     INT             NOT NULL REFERENCES transaction_type (id),
    amount                  DECIMAL(15, 2)  NOT NULL,
    title                   VARCHAR(255)    NOT NULL,
    description             TEXT,
    transfer_ref_id         VARCHAR(255),
    created_at              TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS transaction_categories;
DROP TABLE IF EXISTS transaction_type;
-- +goose StatementEnd
