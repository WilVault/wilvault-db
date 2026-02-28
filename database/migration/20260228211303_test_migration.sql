-- +goose Up
-- +goose StatementBegin
DROP TABLE IF EXISTS test_tbl;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
CREATE TABLE test_tbl (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
-- +goose StatementEnd