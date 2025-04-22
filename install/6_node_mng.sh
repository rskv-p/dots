echo 'Installing fnm...'

# Check if the system is running under "ish" (which doesn't support fnm)
if [ $(uname -r | grep -i ish) ]; then
  echo 'fnm does not work on ish currently, skipping installation.'
  exit 0
fi

# Check if Homebrew is installed and use it if available
if type brew &> /dev/null; then
  echo 'Using Homebrew to install fnm...'
  brew install fnm
else
  # Check if curl is available before attempting to use it
  if type curl &> /dev/null; then
    echo 'Using curl to install fnm...'
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/share/fnm" --skip-shell
  else
    echo 'Error: curl is not installed. Please install curl to proceed with fnm installation.'
    exit 1
  fi
fi

echo 'fnm installation complete!'
