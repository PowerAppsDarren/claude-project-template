# /project:review — Code Review

Review the specified file or directory for quality, security, and adherence to project standards.

## Usage
```
/project:review <file-or-directory>
```

## Instructions

Perform a thorough code review of `$ARGUMENTS` using the following checklist:

### 1. Security
- [ ] No hardcoded secrets, API keys, or credentials
- [ ] Input validation on all external data
- [ ] No SQL injection, XSS, or command injection vectors
- [ ] Proper authentication and authorization checks
- [ ] Sensitive data not exposed in logs or error messages

### 2. Correctness
- [ ] Logic handles edge cases (null, empty, boundary values)
- [ ] Error handling is complete — no swallowed exceptions
- [ ] Async operations properly awaited / error-handled
- [ ] Resource cleanup (connections, file handles, subscriptions)
- [ ] Race conditions considered in concurrent code

### 3. Performance
- [ ] No N+1 queries or unbounded loops
- [ ] Large datasets paginated or streamed
- [ ] Expensive operations cached where appropriate
- [ ] No unnecessary re-renders or recomputations

### 4. Code Quality
- [ ] Functions are focused — single responsibility
- [ ] Naming is clear and intention-revealing
- [ ] No dead code, commented-out code, or TODOs without tickets
- [ ] DRY — but not at the expense of clarity
- [ ] Public API surface is minimal

### 5. Testing
- [ ] Critical paths have test coverage
- [ ] Edge cases and error paths tested
- [ ] Tests are independent and deterministic
- [ ] Mocks are minimal and at boundaries

## Output Format

For each finding, report:
- **Severity**: Critical / Warning / Suggestion
- **Location**: file:line_number
- **Issue**: What's wrong
- **Fix**: How to fix it

Summarize with counts: X critical, Y warnings, Z suggestions.
