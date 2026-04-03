# Claude Code Project Template

A production-ready project template optimized for [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Clone this repo to get a fully configured Claude Code development environment with best-practice settings, rules, skills, agents, and hooks.

## Quick Start

1. **Clone this template**
   ```bash
   git clone https://github.com/YOUR_ORG/claude-project-template.git my-project
   cd my-project
   ```

2. **Customize `CLAUDE.md`** — Replace the TODO placeholders with your project's commands, architecture, conventions, and gotchas. Keep it under 80 lines.

3. **Set up personal overrides**
   ```bash
   cp CLAUDE.local.md.example CLAUDE.local.md
   # Edit CLAUDE.local.md with your personal preferences
   ```

4. **Configure MCP servers** — Edit `.mcp.json` to connect your GitHub, database, monitoring, and other integrations.

5. **Start coding with Claude Code**
   ```bash
   claude
   ```

## Project Structure

```
├── CLAUDE.md                       # Main project instructions (committed)
├── CLAUDE.local.md.example         # Template for personal overrides
├── .mcp.json                       # MCP server integrations
└── .claude/
    ├── settings.json               # Permissions, hooks, and config
    ├── rules/                      # Modular instruction files
    │   ├── code-style.md           # Code style (always active)
    │   ├── testing.md              # Testing rules (active on test files)
    │   └── api-conventions.md      # API rules (active on API files)
    ├── commands/                   # Custom slash commands
    │   ├── review.md               # /project:review — code review
    │   └── fix-issue.md            # /project:fix-issue — issue workflow
    ├── skills/                     # On-demand skill directories
    │   └── deploy/
    │       ├── SKILL.md            # Deploy skill entry point
    │       └── deploy-checklist.md # Deploy reference checklist
    ├── agents/                     # Specialized subagents
    │   ├── code-reviewer.md        # Read-only code reviewer
    │   └── security-auditor.md     # OWASP-focused security scanner
    └── hooks/                      # Hook scripts
        └── block-dangerous.sh      # Blocks dangerous bash commands
```

## What Each Layer Does

| Layer | File(s) | Loaded When | Enforced? |
|-------|---------|-------------|-----------|
| **CLAUDE.md** | `CLAUDE.md` | Every session | Advisory (~80%) |
| **Rules** | `.claude/rules/*.md` | Session start or path match | Advisory (~80%) |
| **Settings** | `.claude/settings.json` | Every session | **Deterministic** |
| **Hooks** | `.claude/hooks/*.sh` | Tool use events | **Deterministic** |
| **Skills** | `.claude/skills/*/SKILL.md` | On demand / context match | Advisory |
| **Agents** | `.claude/agents/*.md` | On delegation | Advisory |
| **Commands** | `.claude/commands/*.md` | Manual `/project:name` | Advisory |
| **MCP** | `.mcp.json` | Every session | Deterministic |

## Customization Guide

### Adding Rules
Create `.md` files in `.claude/rules/`. Add YAML frontmatter with `paths:` to scope rules to specific files:

```yaml
---
paths:
  - "src/components/**/*.tsx"
---
# React Component Rules
- Use functional components with hooks
- Props interfaces must be exported
```

### Adding Skills
Create a directory in `.claude/skills/` with a `SKILL.md` entry point:

```yaml
---
name: my-skill
description: What this skill does
allowed-tools: Read Grep Glob Bash
---
Instructions for the skill...
```

### Adding Agents
Create `.md` files in `.claude/agents/` with YAML frontmatter:

```yaml
---
name: my-agent
description: What this agent specializes in
tools: Read, Glob, Grep
model: sonnet
---
Agent system prompt...
```

### Configuring Hooks
Edit `.claude/settings.json` to add lifecycle hooks. Common patterns:
- **Auto-format**: `PostToolUse` + `Write|Edit` → run your formatter
- **Safety gate**: `PreToolUse` + `Bash` → block dangerous commands
- **Quality check**: `Stop` → run tests before completion

## Key Principles

1. **CLAUDE.md stays lean** — Under 80 lines. Commands first. Only what Claude can't infer from code.
2. **Rules are modular** — One topic per file. Use path scoping to reduce context noise.
3. **Skills load on demand** — Don't bloat session context. Put domain knowledge in skills.
4. **Hooks enforce, CLAUDE.md guides** — Use hooks for guarantees, CLAUDE.md for preferences.
5. **Local files stay local** — `CLAUDE.local.md` and `settings.local.json` are gitignored.

## License

MIT
