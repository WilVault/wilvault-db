-- +goose Up
-- +goose StatementBegin
CREATE TABLE currency (
    id SERIAL PRIMARY KEY,
    currency VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    emoji VARCHAR NOT NULL
);

INSERT INTO currency (currency, description, emoji) VALUES
    ('PHP', 'Philippines Peso', '🇵🇭'),
    ('USD', 'US Dollar', '🇺🇸'),
    ('EUR', 'Euro', '🇪🇺'),
    ('JPY', 'Japanese Yen', '🇯🇵'),
    ('GBP', 'British Pound', '🇬🇧'),
    ('SGD', 'Singapore Dollar', '🇸🇬');
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS currency;
-- +goose StatementEnd