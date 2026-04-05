---
name: deploy
description: Deploy application with safety checks and validation
allowed-tools: Read, Grep, Glob, Bash
paths:
  - "deploy/**"
  - "Dockerfile"
  - "docker-compose*.yml"
  - ".github/workflows/**"
  - "infrastructure/**"
  - "k8s/**"
---

# Deploy Skill

Safely deploy the application with pre-flight checks, validation, and rollback guidance.

## Pre-Deploy Validation

Before deploying, verify ALL of the following:

### 1. Branch & Code State
- Confirm you are on the correct branch: `!git branch --show-current`
- Ensure working directory is clean: `!git status --short`
- Verify latest commit: `!git log --oneline -1`
- Check that CI has passed on this commit

### 2. Environment Check
- Verify target environment is specified (staging, production, etc.)
- Confirm environment variables are set (check `.env.example` against actual config)
- Verify database migrations are up to date
- Check that secrets/credentials are configured in the deployment target

### 3. Build Verification
- Run the full build: `npm run build` (or project equivalent)
- Run the test suite: `npm test` (or project equivalent)
- Run linting: `npm run lint` (or project equivalent)
- Verify no TypeScript/type errors: `npm run typecheck` (or project equivalent)

### 4. Dependency Audit
- Check for known vulnerabilities: `npm audit` (or equivalent)
- Verify lock file is committed and up to date
- No local-only dependencies or file: references

## Deploy Steps

Follow these steps in order:

1. **Tag the release** — create a git tag with the version number
2. **Deploy to staging first** — never skip staging for production deploys
3. **Run smoke tests** — verify core flows work in staging
4. **Deploy to production** — only after staging validation passes
5. **Verify health checks** — confirm all health endpoints return 200
6. **Monitor logs** — watch for errors in the first 10 minutes

## Rollback Procedure

If issues are detected post-deploy:

1. **Revert to previous version** immediately — don't debug in production
2. **Check health endpoints** to confirm rollback succeeded
3. **Investigate** the failure in staging/development
4. **Document** what went wrong in a post-mortem

See [deploy-checklist.md](./deploy-checklist.md) for the detailed checklist.
