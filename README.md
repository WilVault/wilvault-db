# wilvault-db

This repository contains the PostgreSQL database schema and migration scripts for the WilVault ecosystem. All database changes are managed through [Goose](https://github.com/pressly/goose) migration files.

---

## Prerequisites

- [PostgreSQL 16+](https://www.postgresql.org/)
- [Goose](https://github.com/pressly/goose) — install via:
  ```sh
  go install github.com/pressly/goose/v3/cmd/goose@latest
  ```

---

## Installation

### 1. Environment File

Copy the example environment file and fill in your values:

```sh
cp .env.example .env
```

The `.env` file only needs two variables:

- `GOOSE_DRIVER` — must be set to `"postgres"`
- `GOOSE_DBSTRING` — the connection string to your target database

Just swap the database name in `GOOSE_DBSTRING` depending on your environment:

```sh
# Local / dev
GOOSE_DRIVER=postgres
GOOSE_DBSTRING=postgres://wilvault:yourpassword@localhost:5432/wilvault_db

### 2. Load Environment Variables

```sh
set -a; source .env; set +a
```

### 3. Run Migrations

Navigate to the migration directory and run all pending migrations:

```sh
cd database/migration/
goose up
```

If all migration scripts ran without errors, the WilVault database is properly installed.

---

## Database Change Contributions

Whenever the database schema is altered, a migration file **must** be created. See [`MIGRATION.md`](./MIGRATION.md) for detailed instructions on how to create and name migration files.

---


### Option B — Manually

Create the test database:

```sh
sudo su - postgres
psql
```

```sql
CREATE DATABASE wilvault_db;
```

It is recommended to create a dedicated PostgreSQL user for WilVault. Refer to this [tutorial](https://tecadmin.net/postgresql-creating-user-database-and-assign-permissions/) for details.

Once the database is created, update your `.env` to point `GOOSE_DBSTRING` to the test database, reload the environment, and run:

```sh
cd database/migration/
goose up
```

To reset the test database back to a clean state:

```sh
goose reset
```
