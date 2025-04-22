# VSCode & VSCode Insiders command aliases

if type code &> /dev/null; then
  alias c.='code .'        # Open VSCode in the current directory
  alias c,='code .'        # Same as above
  alias c..='code ..'      # Open VSCode in the parent directory
  alias c,,='code ..'      # Same as above
  alias c.,='code ..'      # Same as above
  alias c,.='code ..'      # Same as above
fi

if type code-insiders &> /dev/null; then
  alias ci.='code-insiders .'  # Open Insiders version of VSCode in the current directory
  alias ci,='code-insiders .'  # Same as above
  alias ci='code-insiders'     # Open Insiders version of VSCode
fi
