# Git command aliases

if type git &> /dev/null; then
  alias gbv='git branch -v'              # Show branches with last commit
  alias gbvv='git branch -vv'            # Show branches with detailed info
  alias gcl1='git clone --recurse-submodules --depth 1'  # Shallow clone with submodules
  alias gcot='git checkout --track'     # Checkout and track a remote branch
  alias gdc='git diff --cached'         # Show staged changes
  alias ginit='git init && git add -A && git commit -m "feat: initial commit"'  # Init git repo with first commit
  alias gl1='git log -n 1'              # Show latest commit
  alias gls='git log --show-signature'  # Show log with GPG signature
  alias gpD='git push --delete'         # Delete remote branch
  alias gpt='git push --follow-tags'    # Push tags along with commits
  alias grao='git remote add origin'    # Add origin remote
  alias grau='git remote add upstream'  # Add upstream remote
  alias grmvou='git remote rename origin upstream'  # Rename remote to upstream
  alias grsh='git reset --soft'         # Reset soft (keep changes staged)
  alias gstaa='git stash push --include-untracked'  # Stash with untracked files
  alias gstai='git stash push --include-untracked'  # Same as gstaa
  alias gstau='git stash push --include-untracked'  # Same as gstaa
  alias gsw-='git switch -'             # Switch to previous branch
  alias gundo='git reset --soft HEAD~1' # Undo last commit (soft reset)
  alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "🚧 WIP: work in progress..."'  # Work in progress commit

  # Show graph for git reflog command
  alias glggr='git log --graph --decorate $(git reflog --format=format:%h)'
  alias glogr='git log --oneline --graph --decorate $(git reflog --format=format:%h)'

  # Fix `warning: ignoring broken ref refs/remotes/origin/HEAD` issue
  alias git-fix-ignoring-broken-ref-warning='git remote set-head origin $(git_current_branch)'
fi
