#!/usr/bin/env bash
set -euo pipefail

# Inputs
OWNER="${1:-zubinqayam}"                              # change if needed
REPOLIST_FILE="${2:-repos.txt}"                       # one repo name per line (no owner/)
PKG_DIR="${3:-$PWD/ZQTaskmaster-Package}"             # path to unzipped bundle folder

if [[ ! -d "$PKG_DIR" ]]; then
  echo "Package dir not found: $PKG_DIR"; exit 1
fi
if [[ ! -f "$REPOLIST_FILE" ]]; then
  echo "Repo list missing: $REPOLIST_FILE"; exit 1
fi

branch="zqtaskmaster/bootstrap-$(date +%Y%m%d)"
echo "Using branch: $branch"

while read -r REPO; do
  [[ -z "$REPO" ]] && continue
  workdir="$(mktemp -d)"
  echo ">>> Processing $OWNER/$REPO"

  gh repo clone "$OWNER/$REPO" "$workdir"
  pushd "$workdir" >/dev/null

  git checkout -b "$branch"

  rsync -a --delete "$PKG_DIR"/ ./

  git add .
  git commit -m "chore(zqtaskmaster): bootstrap CI governance (Confirm→Confirm2, cost/risk gate, CodeQL, Gitleaks, SBOM)"
git push -u origin "$branch"

  # Open PR with approval label; assign to you
  gh pr create \
    --title "ZQTaskmaster: bootstrap CI governance (Confirm→Confirm2 gate)" \
    --body "Adds orchestrator workflow, labels bootstrap, Dependabot, CODEOWNERS, security policy, SBOM, and gate logic.\n\n**Next:**\n1) Run 'ZQ Labels Bootstrap' workflow (Actions tab) to create labels.\n2) Optionally add SMTP secrets to enable 3 reminder emails.\n3) Trigger 'ZQTaskmaster Orchestrator' manual run.\n" \
    --label approval \
    --assignee "@me" || true

  # Try to dispatch the labels workflow to save clicks (best effort)
  wf_id=".github/workflows/zq-labels.yml"
  if gh api -X POST "repos/$OWNER/$REPO/actions/workflows/"$(basename "$wf_id")"/dispatches" -f ref="$branch" >/dev/null 2>&1; then
    echo "Dispatched labels workflow on $OWNER/$REPO"
  else
    echo "Manual run of 'ZQ Labels Bootstrap' required for $OWNER/$REPO"
  fi

  popd >/dev/null
  rm -rf "$workdir"
done < "$REPOLIST_FILE"

echo ">>> Rollout queued. Review PRs, add labels Confirm & Confirm2 on the Approval issue when paused, then ship."