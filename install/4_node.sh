echo 'Installing Node.js...'

# Check if the system is running under "ish" (which doesn't support fnm)
if [ $(uname -r | grep -i ish) ]; then
  echo 'Installing Node.js via apk...'
  apk add nodejs-current nodejs-current-doc npm
  exit 0
fi

# Ensure fnm is installed
if ! type fnm &> /dev/null; then
  echo 'fnm is not installed, installing via curl...'
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/share/fnm" --skip-shell
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "$(fnm env)"
fi

echo 'Installing Node.js via fnm...'

# Install the LTS version of Node.js
fnm install --lts
fnm alias lts-latest default

# Ensure npm is up-to-date
echo 'Updating npm to the latest version...'
npm i -g npm@latest

# Remove the global corepack package if it exists
echo 'Removing global corepack package...'
npm rm -g corepack

# Install global npm packages
echo 'Installing global npm packages: @antfu/ni, pnpm, yarn...'
npm i -g @antfu/ni pnpm@latest yarn@latest

echo 'Node.js installation complete!'
