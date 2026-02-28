# MIGRATION.md — WilVault Database Migrations

This document explains how to create, apply, and roll back database migrations using [Goose](https://github.com/pressly/goose).

---

## Overview

All schema changes — table creation, column additions, index changes, etc. — must be tracked as migration files inside `database/migration/`. This keeps the database history auditable and reproducible across all environments (local, staging, production).

---

## Naming Convention

Goose migration files follow this naming pattern:

```
{YYYYMMDDHHMMSS}_{description}.sql
```

The timestamp is automatically set to the current date and time when you run `goose create` — you don't need to set it manually.

---

## Creating a Migration

This project uses **timestamp-based** migration filenames (`YYYYMMDDHHMMSS`), which is the default Goose behavior.

> ⚠️ Never use the `-s` flag — that switches Goose to sequential numbering (e.g. `00001_name.sql`) which we do not use here.

Use Goose to generate a new migration file:

```sh
cd database/migration/
goose create {description} sql
```

Example:
```sh
goose create create_users_table sql
```

This generates a timestamped file like `20240101153000_create_users_table.sql` with the following template:

```sql
-- +goose Up
-- +goose StatementBegin

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

-- +goose StatementEnd
```

Fill in:
- `Up` — the SQL to apply the change (e.g., `CREATE TABLE`, `ALTER TABLE`)
- `Down` — the SQL to reverse the change (e.g., `DROP TABLE`, `ALTER TABLE ... DROP COLUMN`)

---

## Applying Migrations

First, load your environment:

```sh
set -a; source .env; set +a
```

Then navigate to the migration directory:

```sh
cd database/migration/
```

| Command             | Description                                      |
|---------------------|--------------------------------------------------|
| `goose up`          | Apply all pending migrations                     |
| `goose up-by-one`   | Apply only the next pending migration            |
| `goose down`        | Roll back the most recently applied migration    |
| `goose reset`       | Roll back **all** applied migrations             |
| `goose status`      | Show the current migration status                |
| `goose version`     | Show the current schema version                  |

---

## Example Migration

`20240101000000_create_users_table.sql`

```sql
-- +goose Up
-- +goose StatementBegin
CREATE TABLE users (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email       VARCHAR(255) NOT NULL UNIQUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS users;
-- +goose StatementEnd
```

---

## Important Rules

- **Always use `goose create`** to generate files — never create them manually, so the timestamp is always accurate.
- **Never use the `-s` flag** with `goose create`. This project uses timestamps, not sequential numbers.
- **Never modify** an already-applied migration file. Always create a new one.
- Always provide a valid `Down` block so migrations can be safely rolled back.
- Test your migration locally before pushing to any shared environment.
- On production (EC2), always take a database snapshot/backup before running `goose up`.

---

## Switching Branches

This is a common gotcha — **checking out a branch does not change your database state.** Goose tracks applied migrations inside the database itself (in a table called `goose_db_version`), so your DB stays at whatever version it was last migrated to regardless of what branch you're on.

**Example scenario:**
- Branch A has 2 migrations
- Branch B has 3 migrations
- You're on Branch B and ran `goose up` → database is at version 3
- You checkout Branch A → the SQL file for migration 3 is now gone from your filesystem, but the database still has it applied — your code and DB are now **out of sync**

**The safe way to switch to a branch with fewer migrations:**

```sh
# Before checking out the other branch, roll back the extra migrations
cd database/migration/
goose down  # rolls back one migration at a time
```

Or roll back to a specific version in one go:

```sh
goose down-to 20240101153000  # timestamp of the last migration in the target branch
```

Then checkout the branch — your DB and code will be in sync.

You can always check your current database version with:

```sh
goose status
```