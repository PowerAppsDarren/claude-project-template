# Project Name

## Commands
```bash
# TODO: Replace with your actual commands
npm run build          # Build the project
npm test               # Run test suite
npm run lint           # Lint and auto-fix
npm run typecheck      # Type checking
npm run dev            # Start dev server
```

## What This Is
TODO: One-sentence description of what this project does and why it exists.

## Architecture
TODO: Key navigation hints for Claude. Examples:
- Monorepo with packages in `packages/`
- Core logic in `src/core/`, API layer in `src/api/`, UI in `src/components/`
- Database models in `src/models/`, migrations in `db/migrations/`
- Shared types in `src/types/`

## Things That Will Bite You
TODO: Gotchas that Claude can't infer from code. Examples:
- Strict TypeScript: `noUnusedLocals` enabled
- Database queries must use the query builder, never raw SQL
- Auth tokens expire after 15 minutes; refresh logic is in `src/auth/refresh.ts`
- CI runs on Node 20 — don't use Node 22 features

## Code Conventions
TODO: Only list conventions that differ from language defaults. Examples:
- Named exports only, never default exports
- Use `Result<T, E>` pattern for error handling, not exceptions
- All API responses use the envelope format from `src/lib/response.ts`
- Prefer composition over inheritance

## Docs Reference
TODO: Point Claude to detailed docs instead of inlining them:
- Architecture deep-dive: `docs/architecture.md`
- Database schema: `docs/database.md`
- API documentation: `docs/api.md`
- Contributing guide: `CONTRIBUTING.md`
