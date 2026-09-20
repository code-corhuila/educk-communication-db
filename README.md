# educk-communication-db

> Communication Bounded Context: Database Schema, Seeds & Migrations (`educk-comm-db`)

Part of the **eduTrack** distributed system — Team G1.  
Governance and documentation live in [`educk-docs`](https://github.com/code-corhuila/educk-docs).

---

## 1. Database Specifications

- **Engine:** PostgreSQL 16 Alpine
- **Database Name:** `communication_db`
- **Container Name:** `educk-comm-db`
- **Host Port:** `5433` / **Internal Port:** `5432`
- **Schema Ownership:** Follows ADR-003 (Database per Service) and course standard `<abbr>-<domain>-db`. Schema migrations reside exclusively in this repository.

## 2. Migrations Directory

- `migrations/V1__create_messages_table.sql`: Creates `messages` table with primary key UUID and composite conversation indexes.
- `seeds/01_seed_test_messages.sql`: Deterministic seed data for local testing and CI verification.

## 3. Branching & Governance

Three permanent branches. **None of them accepts a direct commit** — you enter through a child branch and leave through a Pull Request:

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent branch into another (`merge develop -> qa` and `merge qa -> main` are strictly prohibited).

`main` requires **1 approval from `@ariel5253`**. On `develop` and `qa`, the team requires 1 approving peer review.

Full policy: `00-governance/branching-policy.md` in [`educk-docs`](https://github.com/code-corhuila/educk-docs).

## 4. Running Database Locally

```bash
cp .env.example .env
docker compose up -d
```

When started, Docker Compose will:
1. Launch PostgreSQL 16 (`educk-comm-db`) and wait for its healthcheck (`pg_isready`).
2. Run Flyway container (`educk-comm-migration`) to apply all pending `migrations/V*__*.sql` versioned migrations.
3. Run Seed container (`educk-comm-seed`) to populate `seeds/01_seed_test_messages.sql` idempotently.

