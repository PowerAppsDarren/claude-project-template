# Code Style Rules

These rules apply to all files in the project. They are language-agnostic
guidelines — adapt the specifics to your stack.

## Naming
- Use descriptive, intention-revealing names — no abbreviations unless universally understood (e.g., `id`, `url`, `http`)
- Functions: verb-first (`getUserById`, `calculateTotal`, `validate_input`)
- Booleans: prefix with `is`, `has`, `can`, `should` (`isActive`, `hasPermission`)
- Constants: UPPER_SNAKE_CASE for true constants, camelCase/snake_case for config values
- Files: match the primary export or class name; use consistent casing per language convention

## Structure
- One concept per file — don't mix unrelated logic
- Keep functions under 40 lines; extract when complexity grows, not preemptively
- Prefer flat over nested — early returns reduce indentation
- Group imports: stdlib/built-in first, then external deps, then internal modules

## Error Handling
- Handle errors at the appropriate boundary — don't swallow them silently
- Use the project's established error pattern (exceptions, Result types, error codes)
- Include context in error messages: what failed, why, and what to do about it
- Never expose internal details (stack traces, SQL, file paths) in user-facing errors

## General
- No magic numbers or strings — extract named constants
- Prefer composition over inheritance
- Don't add code "just in case" — implement what's needed now
- Delete dead code instead of commenting it out — git has history
- Keep public API surfaces small — expose the minimum necessary
