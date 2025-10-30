# ZQTaskmaster Bootstrap Automation

This directory contains automation for bootstrapping CI governance across multiple repositories using ZQTaskmaster.

## Workflows

### ZQTaskmaster Bootstrap CI Governance
**File:** `.github/workflows/zq-bootstrap-ci-governance.yml`

Automates the process of deploying ZQTaskmaster CI governance to multiple repositories.

#### Features
- Clones target repositories
- Creates a dated branch (`zqtaskmaster/bootstrap-YYYYMMDD`)
- Copies ZQTaskmaster package files
- Commits and pushes changes
- Creates pull requests with approval labels
- Dispatches the labels bootstrap workflow automatically

#### Usage

1. **Prepare the ZQTaskmaster Package**
   - Ensure the ZQTaskmaster package is available in your repository
   - Default location: `ZQTaskmaster-Package/`
   - The package should contain all necessary CI governance files

2. **Run the Workflow**
   - Go to Actions tab in GitHub
   - Select "ZQTaskmaster Bootstrap CI Governance"
   - Click "Run workflow"
   - Fill in the required inputs:
     - **Repository owner**: Organization or username (default: `zubinqayam`)
     - **Repository list**: Comma-separated list of repo names (e.g., `repo1,repo2,repo3`)
     - **Package path**: Path to ZQTaskmaster package (default: `ZQTaskmaster-Package`)

3. **Review and Merge**
   - Review the created PRs in target repositories
   - Run "ZQ Labels Bootstrap" workflow in each repository (if not auto-dispatched)
   - Add `Confirm` and `Confirm2` labels when ready
   - Merge the PRs

#### Example

To bootstrap repositories `my-app` and `my-service`:

```yaml
Repository owner: zubinqayam
Repository list: my-app,my-service
Package path: ZQTaskmaster-Package
```

## Scripts

### rollout-zqtaskmaster.sh
**File:** `scripts/rollout-zqtaskmaster.sh`

Original bash script for manual rollout. The GitHub Actions workflow automates this process.

#### Usage
```bash
./scripts/rollout-zqtaskmaster.sh [OWNER] [REPOLIST_FILE] [PKG_DIR]
```

**Parameters:**
- `OWNER`: Repository owner (default: `zubinqayam`)
- `REPOLIST_FILE`: File containing repository names, one per line (default: `repos.txt`)
- `PKG_DIR`: Path to ZQTaskmaster package directory (default: `$PWD/ZQTaskmaster-Package`)

**Example:**
```bash
./scripts/rollout-zqtaskmaster.sh zubinqayam repos.txt ./ZQTaskmaster-Package
```

## Requirements

- GitHub CLI (`gh`) installed (automatically installed in workflow)
- `rsync` available (standard in Linux/macOS)
- Appropriate GitHub permissions:
  - `contents: write` - for pushing branches
  - `pull-requests: write` - for creating PRs
  - `actions: write` - for dispatching workflows

## Branch Naming Convention

Branches are created with the format: `zqtaskmaster/bootstrap-YYYYMMDD`

Example: `zqtaskmaster/bootstrap-20251029`

## Next Steps

After the bootstrap process completes:

1. Review the created pull requests in each target repository
2. Run the "ZQ Labels Bootstrap" workflow (if not auto-dispatched) to create required labels
3. Optionally configure SMTP secrets for reminder emails
4. Trigger the "ZQTaskmaster Orchestrator" workflow for a manual run
5. Add `Confirm` and `Confirm2` labels on the approval issues as needed
6. Merge the PRs to activate CI governance
