# /project:fix-issue — Issue Resolution Workflow

Systematically investigate and fix an issue using a structured approach.

## Usage
```
/project:fix-issue <issue-description-or-number>
```

## Instructions

Fix the following issue: `$ARGUMENTS`

Follow this workflow strictly:

### Step 1: Understand
- Read the issue description carefully
- Identify the expected vs actual behavior
- Determine which area of the codebase is likely affected
- Search for related code using Grep and Glob

### Step 2: Reproduce
- Find or write a minimal reproduction case
- If a test can reproduce the bug, write it first (it should fail)
- Document the exact steps to trigger the issue

### Step 3: Root Cause
- Trace the code path from trigger to failure
- Identify the specific line(s) causing the bug
- Explain WHY the bug occurs, not just WHERE
- Check if the same pattern exists elsewhere (same bug, different location)

### Step 4: Fix
- Make the minimal change that fixes the root cause
- Don't refactor surrounding code — stay focused on the fix
- Ensure the fix handles edge cases
- Verify no regressions in adjacent functionality

### Step 5: Test
- Verify the failing test now passes
- Add tests for edge cases discovered during investigation
- Run the full test suite to check for regressions
- If no test framework exists, manually verify and document steps

### Step 6: Summary
Report:
- **Root cause**: One-sentence explanation
- **Fix**: What was changed and why
- **Files modified**: List with brief description per file
- **Tests**: What test coverage was added
- **Risk**: Low/Medium/High — likelihood of side effects
