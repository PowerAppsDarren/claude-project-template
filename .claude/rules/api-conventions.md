---
paths:
  - "src/api/**"
  - "**/routes/**"
  - "**/controllers/**"
  - "**/handlers/**"
  - "**/endpoints/**"
  - "**/*.graphql"
  - "**/schema.prisma"
---

# API Conventions

These rules activate when working with API-related files.

## Endpoint Design
- Use RESTful resource naming: `/users`, `/users/:id`, `/users/:id/orders`
- Use plural nouns for collections, never verbs in URLs
- HTTP methods convey action: GET (read), POST (create), PUT/PATCH (update), DELETE (remove)
- Use query parameters for filtering, sorting, pagination: `?status=active&sort=-created_at&limit=20`

## Request Validation
- Validate all input at the API boundary — never trust client data
- Use schema validation (zod, joi, pydantic, JSON Schema) — not manual checks
- Return 400 with specific field-level error messages for validation failures
- Sanitize strings to prevent injection (SQL, XSS, command injection)

## Response Format
- Use a consistent envelope format across all endpoints:
  ```json
  { "data": { ... }, "meta": { "page": 1, "total": 42 } }
  { "error": { "code": "NOT_FOUND", "message": "User not found" } }
  ```
- Use appropriate HTTP status codes: 200 (ok), 201 (created), 204 (no content), 400 (bad request), 401 (unauthorized), 403 (forbidden), 404 (not found), 422 (validation), 500 (server error)
- Return ISO 8601 dates, consistent ID formats, and null (not undefined) for missing fields

## Error Handling
- Never expose internal errors (stack traces, SQL queries, file paths) to clients
- Log full error details server-side; return sanitized messages to clients
- Use error codes (machine-readable) alongside messages (human-readable)
- Handle errors at the controller/handler level — don't let raw exceptions reach the client

## Authentication & Authorization
- Authenticate before processing any business logic
- Authorize at the resource level — check ownership/permissions per request
- Use middleware/guards for cross-cutting auth concerns
- Never include secrets, tokens, or credentials in URLs or logs

## Performance
- Paginate all list endpoints — never return unbounded results
- Use appropriate caching headers (ETag, Cache-Control)
- Avoid N+1 queries — eager-load or batch related data
- Set reasonable request size limits and timeouts
