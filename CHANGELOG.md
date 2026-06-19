# Changelog

All notable changes to this project will be documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.0] — 2026-06-19

### Added

**Dev Container**
- VS Code DevContainer based on `mcr.microsoft.com/devcontainers/python:3.13`
- Node.js feature for Claude Code CLI support
- Port 8888 forwarded for JupyterLab
- `~/.claude` bind-mounted so Claude Code settings persist across container rebuilds
- `postCreateCommand` installs dev dependencies, pre-commit hooks, and Claude Code CLI

**Scientific Stack**
- JupyterLab with auto-save and line numbers
- NumPy, Pandas, Matplotlib, Seaborn, SciPy pre-installed
- Starter notebook template with structured sections scaffold

**Code Quality**
- `ruff` for linting and formatting, applied to notebooks via `nbqa`
- `nbstripout` strips cell outputs before every commit
- `.gitattributes` for meaningful notebook diffs
- Pre-commit hook wiring for both tools

**VS Code Integration**
- 15+ pre-configured tasks: start Jupyter, lint/format notebooks, export, template creation, Quarto, and more
- Pre-installed extensions: Jupyter, Ruff, GitHub Copilot Chat, Quarto
- Launch config for JupyterLab

**Quarto**
- Quarto CLI pre-installed in the container
- `_quarto.yml` project config
- VS Code tasks for preview, render, and publish

**AI Tooling**
- `CLAUDE.md` with project conventions for AI assistants
- `template.env` with `OPENAI_API_KEY` and `JUPYTER_TOKEN` patterns
- `jupyter-mcp-server` pre-installed; `.claude/settings.json` registers it as a project-level MCP server so Claude Code can read and execute notebook cells when JupyterLab is running
- `JUPYTER_TOKEN` container environment variable wired through DevContainer, Makefile, and VS Code tasks so token is consistent across all entry points
