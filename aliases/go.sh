# Go command aliases

if type go &> /dev/null; then
  # Build the Go project
  alias gb='go build'             # Build the current Go project
  alias gr='go run'               # Run the current Go project
  alias gt='go test'              # Run tests for the current Go project
  alias gtid='go test -i'         # Install dependencies for tests (without running)
  alias gci='go clean -i'         # Clean Go build cache and remove compiled files

  # Go module management
  alias gmod='go mod tidy'        # Clean up and update Go modules
  alias gmodv='go mod vendor'     # Vendor the Go modules
  alias gsum='go mod verify'      # Verify dependencies in Go modules

  # Run Go program with the specified file
  alias grun='go run ./$1'        # Run a specific Go file (e.g., grun main.go)

  # Go Documentation
  alias godoc='go doc'            # Display Go documentation for a package or function

  # Go version and environment
  alias gov='go version'          # Display current Go version
  alias goenv='go env'            # Show Go environment variables
  alias goget='go get'            # Get a Go module

  # Common Go utilities
  alias gfmt='gofmt -w'           # Format Go source code
  alias gvet='go vet'             # Run the Go vet tool to find potential errors

  # List installed Go modules
  alias gls='go list -m all'      # List all modules in the current Go project
fi
