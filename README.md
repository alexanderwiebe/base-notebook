# base-notebook: ML/AI Development Starting Point

A production-ready template for Python-based ML/AI development in Jupyter, with the right defaults baked in from day one.

## Why It Works Well as a Starting Point

It's minimal enough to not be opinionated about your problem domain, but opinionated about the things that cause pain: environment drift, noisy git history, inconsistent formatting, and slow project setup. The hard parts (nbstripout wiring, ruff for notebooks, DevContainer config) are already done.

## What's Included

**Reproducible Environments**
- VS Code DevContainer with Python 3.13 — works identically locally, on any teammate's machine, or in GitHub Codespaces
- `make setup` gets you running outside a container too

**Scientific Stack, Pre-Configured**
- NumPy, Pandas, Matplotlib, Seaborn, SciPy — ready to import
- JupyterLab with auto-save, line numbers, and port forwarding on 8888

**Code Quality Built-In**
- `ruff` for linting and formatting — applied to notebooks via `nbqa`, not just Python files
- VS Code tasks for lint, format, and quality checks with one click

**Clean Git History for Notebooks**
- `nbstripout` strips cell outputs before every commit — no more multi-MB diffs from running a cell
- `.gitattributes` configures meaningful notebook diffs
- Automatic install via DevContainer post-create hook and `make setup`

**VS Code Workflow**
- 15+ pre-configured tasks: start Jupyter, lint/format notebooks, create from template, export to HTML or script, check outdated packages
- Pre-installed extensions: Jupyter, Ruff, GitHub Copilot Chat
- Launch config to start JupyterLab with no password friction

**Notebook Template**
- Starter notebook with imports, `%matplotlib inline`, and a structured sections scaffold
- VS Code task to create a new named notebook from the template

**AI-Ready**
- GitHub Copilot Chat pre-installed
- OpenAI API key pattern established via `template.env`
- CLAUDE.md with project conventions so AI assistants follow the same standards
- Optional Jupyter MCP server — gives Claude Code direct read/execute access to running notebooks

## Getting Started

1. Open this folder in **VS Code**
2. If prompted, reopen in container
3. Run `jupyter lab` inside the terminal
4. Explore `notebooks/`

Outside a container: run `make setup` then start Jupyter.

## 📄 Quarto

[Quarto](https://quarto.org) is pre-installed in the dev container and renders notebooks to HTML, PDF, and more.

**VS Code tasks** (via `Tasks: Run Task`):

| Task | Description |
|------|-------------|
| Quarto Preview | Live preview at `localhost:4848` |
| Quarto Render | Render all notebooks to `_site/` |
| Quarto Render Active File | Render only the open file |
| Quarto Publish | Publish to Quarto Pub / GitHub Pages |

**CLI equivalents:**

```bash
quarto preview                  # live preview
quarto render                   # render all to _site/
quarto render notebooks/01_init_notebook.ipynb
quarto publish quarto-pub       # publish to quartopub.com
```

Project output settings are in `_quarto.yml`.

## 🤖 Jupyter MCP Server

The dev container ships with [`jupyter-mcp-server`](https://github.com/datalayer/jupyter-mcp-server) and [`jupyter-collaboration`](https://github.com/jupyterlab/jupyter-collaboration) pre-installed. When JupyterLab is running, Claude Code can read cells, execute code, and inspect outputs directly through the `jupyter` MCP tool — no copy-pasting needed.

### Architecture

**Claude Code always runs inside the dev container** — not on the host. This means:

- `localhost` inside the container is the container, not the host machine
- All Python, Jupyter, and MCP dependencies live in the container
- The host's `~/.claude/` is bind-mounted into the container so Claude Code settings persist across rebuilds
- The host cannot be configured from within the container — any host-side changes must be made manually on the host

There are two MCP connection modes depending on where Claude Code is running:

| Claude Code location | Transport | Config location |
|---|---|---|
| Inside the container | stdio (automatic) | `.claude/settings.json` in this repo |
| On the host machine | streamable-http via port 4040 | `~/.claude/settings.json` on the host |

### MCP tool capabilities

| Tool | What it does | Requires |
|---|---|---|
| `execute_code` | Run arbitrary code on the active kernel | JupyterLab running |
| `execute_cell` | Run a specific cell by index from a notebook | Notebook open in JupyterLab UI (collaboration session) |
| `read_notebook` | Read notebook cells and outputs | JupyterLab running |

### Setup (one time)

Copy `template.env` to `.env`:

```bash
cp template.env .env
# JUPYTER_TOKEN=dev  ← default, change if needed
```

### Starting services

Both JupyterLab and the MCP server must be running. Start them in separate terminals:

```bash
make jupyter       # JupyterLab on port 8888
make mcp-server    # MCP server on port 4040 (for host access)
```

Or use the VS Code tasks: **Start Jupyter Lab** and **Start MCP Server (Remote)**.

### Connecting Claude Code inside the container

No action needed. `.claude/settings.json` in this repo registers `jupyter-mcp-server` via stdio automatically when Claude Code starts. Run `/mcp` in Claude Code to confirm the `jupyter` server is listed.

### Connecting Claude Code from the host machine

Port 4040 is forwarded from the container to the host by the devcontainer config. Once the MCP server is running inside the container, add this block to `~/.claude/settings.json` **on the host** (one time, manually):

```json
{
  "mcpServers": {
    "jupyter": {
      "type": "http",
      "url": "http://localhost:4040/mcp",
      "headers": {
        "Authorization": "Bearer dev"
      }
    }
  }
}
```

Restart Claude Code on the host, then run `/mcp` to verify the `jupyter` server connects.

## 🔑 API Keys

Copy `template.env` to `.env` and fill in your keys:

```bash
cp template.env .env
```
