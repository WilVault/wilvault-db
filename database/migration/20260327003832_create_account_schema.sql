-- +goose Up
-- +goose StatementBegin
CREATE TABLE account_type (
    id    SERIAL PRIMARY KEY,
    label VARCHAR(50) NOT NULL
);

INSERT INTO account_type (label) VALUES
    ('Checking'),
    ('Savings'),
    ('E-wallet'),
    ('Cash'),
    ('Investment'),
    ('Credit Card');

CREATE TABLE account (
    id              SERIAL PRIMARY KEY,
    person_id       INT          NOT NULL,
    account_name    VARCHAR(255) NOT NULL,
    account_type_id INT          NOT NULL REFERENCES account_type (id),
    color           VARCHAR(50),
    icon            VARCHAR(255)
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS account_type;
-- +goose StatementEnd
