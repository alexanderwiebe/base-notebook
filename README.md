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

The dev container ships with [`jupyter-mcp-server`](https://github.com/datalayer/jupyter-mcp-server) pre-installed. When JupyterLab is running, Claude Code can read cells, execute code, and inspect outputs directly through the `jupyter` MCP tool — no copy-pasting needed.

**Setup (one time)**

Copy `template.env` to `.env`. The default token is already set:

```bash
cp template.env .env
# JUPYTER_TOKEN=dev  ← already there, change it if you want
```

**Starting JupyterLab for MCP**

Use the VS Code task or the Makefile target — both start Jupyter with the token that `.claude/settings.json` expects:

| Method | Command |
|--------|---------|
| VS Code task | `Tasks: Run Task` → **Start Jupyter Lab** |
| Terminal | `make jupyter` |
| CLI | `jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --IdentityProvider.token=dev` |

**VS Code tasks:**

| Task | Description |
|------|-------------|
| Start Jupyter Lab | Start JupyterLab with `JUPYTER_TOKEN` so Claude Code can connect |
| Show Jupyter Token | Print the current token value for debugging |

**How it works**

`.claude/settings.json` registers `jupyter-mcp-server` as a project-level MCP server pointed at `localhost:8888`. Claude Code starts the MCP process automatically — the server is available any time JupyterLab is running and inactive otherwise. No manual start/stop needed.

**Configuration** (`.claude/settings.json`):

```json
{
  "mcpServers": {
    "jupyter": {
      "command": "jupyter-mcp-server",
      "env": {
        "JUPYTER_URL": "http://localhost:8888",
        "JUPYTER_TOKEN": "dev",
        "ALLOW_IMG_OUTPUT": "true"
      }
    }
  }
}
```

Change `JUPYTER_TOKEN` here and in `template.env`/`.env` if you use a different token.

## 🔑 API Keys

Copy `template.env` to `.env` and fill in your keys:

```bash
cp template.env .env
```
