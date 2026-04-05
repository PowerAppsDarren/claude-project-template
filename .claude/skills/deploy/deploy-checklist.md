# Deploy Checklist

Use this checklist for every deployment. Copy into a PR comment or issue and check off as you go.

## Pre-Deploy
- [ ] All tests passing on CI
- [ ] Code reviewed and approved
- [ ] No unresolved security vulnerabilities (`npm audit` / `pip audit`)
- [ ] Database migrations tested on staging
- [ ] Environment variables verified for target environment
- [ ] Feature flags configured correctly
- [ ] API versioning confirmed (no breaking changes without version bump)
- [ ] Documentation updated if public API changed

## During Deploy
- [ ] Staging deploy completed successfully
- [ ] Smoke tests passing on staging
- [ ] Performance baseline checked (no regressions)
- [ ] Production deploy initiated
- [ ] Health check endpoints returning 200
- [ ] No error spikes in monitoring

## Post-Deploy
- [ ] Core user flows verified in production
- [ ] Error rates within normal range
- [ ] Performance metrics within acceptable thresholds
- [ ] Stakeholders notified of successful deploy
- [ ] Git tag created for release
- [ ] Release notes published (if applicable)

## Rollback Triggers
Deploy should be rolled back immediately if ANY of the following occur:
- Error rate exceeds 5% of requests
- P95 latency increases by more than 50%
- Health check endpoints failing
- Critical user flow broken (login, checkout, etc.)
- Data integrity issues detected

## Environment Configuration

| Parameter | Staging | Production |
|-----------|---------|------------|
| URL | `TODO: staging-url` | `TODO: production-url` |
| Health Check | `TODO: /health` | `TODO: /health` |
| Log Level | `debug` | `warn` |
| Min Instances | 1 | TODO |
| Max Instances | 2 | TODO |
