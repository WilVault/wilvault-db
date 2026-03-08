-- +goose Up
-- +goose StatementBegin
CREATE TABLE test_tbl_2 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS test_tbl_2;
-- +goose StatementEnd
