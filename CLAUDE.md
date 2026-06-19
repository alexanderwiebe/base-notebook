# Architecture

Claude Code runs **inside the dev container**, not on the host machine. This means:

- File paths, processes, and network addresses are all relative to the container
- `localhost` refers to the container, not the host
- The host's `~/.claude/` is bind-mounted into the container, so user-level Claude settings persist across rebuilds, but the host filesystem is otherwise not accessible
- Changes to `~/.claude/settings.json` cannot be made from here — instruct the user to make those changes manually on their host

**MCP architecture:**
- In-container Claude Code connects to `jupyter-mcp-server` via stdio (`.claude/settings.json` in this repo)
- Host Claude Code connects to `jupyter-mcp-server` via streamable-http on port 4040 (forwarded by VS Code) — the user must configure this in `~/.claude/settings.json` on their host manually

# Code Style

- Prefer `assert` statements over code comments to document assumptions and expectations. Instead of `# age must be non-negative`, write `assert age >= 0`.

# Git

- Do not include Claude co-author information in commit messages.
