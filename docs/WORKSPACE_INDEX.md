# Workspace Index

This git repository is rooted at the home directory (`C:\Users\zubin`), so it contains many unrelated projects, tool configs and dotfiles. Most of the content is untracked. This README is a map of the project folders. Each project keeps its own README with the details.

## Projects

| Folder | What it is | Docs |
|---|---|---|
| [ZQ_DRR/](ZQ_DRR/) | ZQ Deep Review Room. A unified program on INNM-WOSDS v2.0.0, governed by ZQ_DRR_Taskmaster and accessed through a key-secured UI (ZQ_KeyBox). | [README](ZQ_DRR/README.md), [QUICKSTART](ZQ_DRR/QUICKSTART.md), [INSTALL](ZQ_DRR/INSTALL.md) |
| [ZQ_Taskbox/](ZQ_Taskbox/) | INNM Taskbox V2. Kivy UI (`main.py`, `ui.kv`) with a coordinator and controller (`coordinator.py`, `innm_controller.py`). Packaged with PyInstaller and Buildozer. | [README](ZQ_Taskbox/README.md), [DEPLOY_GUIDE](ZQ_Taskbox/DEPLOY_GUIDE.md) |
| [zq_autoser_os-xv1/](zq_autoser_os-xv1/) | ZQ AutoServ OS × XV1. Governance-grade social content workflows, Taskmaster advisory, C3 dispatch and Mr.Q verification. Proprietary. Status is `SYNTHETIC_ONLY`, so these are design decisions, not deployed capability. | [README](zq_autoser_os-xv1/README.md), [SECURITY](zq_autoser_os-xv1/SECURITY.md) |
| [innm_hub/](innm_hub/) | INNM Hub in Python. Terminal chat, FastAPI server, document scanner, folder index and a morning review. | See `main.py` |
| [zq-master-bridge-v2/](zq-master-bridge-v2/) | React + TypeScript sample app with a chat input UI. | [README](zq-master-bridge-v2/README.md) |
| [zq-master-bridge/](zq-master-bridge/) | Tauri desktop shell (`src-tauri/`). | none |
| [digital-innovation-agents/](digital-innovation-agents/) | Agent definitions. | none |
| [AISuite/](AISuite/) | AISuite v2 runtime state (governance, licensing, registry, telemetry, logs). | none |
| [copilot-worktrees/](copilot-worktrees/) | Git worktrees created by Copilot (a copy of `zq_autoser_os-xv1`). | none |

## Running innm_hub

```powershell
cd innm_hub
python main.py                          # terminal chat (default)
python main.py --ui api --port 8765     # API server (needs fastapi + uvicorn)
python main.py --message "What documents mention cold chain?"
python main.py --scan                   # trigger a scan and exit
python main.py --review                 # generate the morning review and exit
```

## Top-level files

- `package.json`: only depends on `@vercel/speed-insights`.
- `INNM-WOSDS v1.3 Canonical Merged Specification.pdf`: reference spec for the INNM-WOSDS core.
- `innm_hub.zip`, `zq-master-bridge-v2.zip`: archived copies of the folders of the same name.
- `.gitignore`: ignores `node_modules` only.

## Notes

- Everything under the home directory shows up in `git status` (dotfiles, `AppData/`, `NTUSER.DAT*`, and so on). To make the repo usable, either add ignore rules for those paths or move each project into its own repository.
- Do not commit `.ssh/`, `.gnupg/`, `.claude.json*`, `.npmrc`, `.mcp-auth/` or `.bash_history`. They hold credentials or tokens.
- Copyright and licence terms differ per project. Check each project's own `LICENSE`.
