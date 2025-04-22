# Bun command aliases

if type bun &> /dev/null; then
  alias bls='bun pm ls'                   # List installed packages
  alias blsall='bun pm ls --all'          # List all packages
  alias blso='bun outdated'               # List outdated packages

  # Equivalent of `npm ci` (clean install)
  alias bci='rm -fr node_modules && bun install --frozen-lockfile'
fi
