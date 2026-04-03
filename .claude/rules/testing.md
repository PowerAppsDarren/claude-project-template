---
paths:
  - "**/*.test.*"
  - "**/*.spec.*"
  - "**/tests/**"
  - "**/__tests__/**"
  - "**/test/**"
---

# Testing Rules

These rules activate when working with test files.

## Test Structure
- Follow Arrange-Act-Assert (AAA) pattern — clearly separate setup, action, and verification
- One logical assertion per test — test one behavior, not one assertion keyword
- Test names describe the behavior: `should return empty array when no items match`
- Group related tests with describe/context blocks that read as specifications

## Test Independence
- Each test must run independently — no shared mutable state between tests
- Use setup/teardown (beforeEach/setUp) for common initialization
- Never depend on test execution order
- Clean up side effects (files, database records, environment variables)

## Mocking
- Mock at boundaries — external APIs, databases, file system, time
- Don't mock what you own — test internal modules with real implementations
- Keep mock data minimal and realistic — use factories or fixtures
- Assert mock interactions only when the interaction itself is the behavior under test

## Coverage & Quality
- Write tests for bug fixes first (reproduce, then fix)
- Cover happy path, edge cases, and error cases
- Don't test implementation details — test observable behavior
- Avoid snapshot tests unless the output format is the contract (e.g., serialization)

## Performance
- Tests should be fast — mock slow dependencies (network, disk)
- Use parallelization where the test framework supports it
- Avoid sleep/delay in tests — use polling or event-driven waits
