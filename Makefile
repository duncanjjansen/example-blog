# Makefile for Tech Blog

.PHONY: blog serve clean install help

# Default target
help:
	@echo "Available commands:"
	@echo "  make blog     - Start local server to preview blog"
	@echo "  make serve    - Same as 'make blog'"
	@echo "  make install  - Install dependencies (if needed)"
	@echo "  make clean    - Clean up temporary files"
	@echo "  make help     - Show this help message"

# Main command to run the blog locally
blog: serve

# Start a local HTTP server
serve:
	@echo "Starting local server for blog preview..."
	@echo "Blog will be available at: http://localhost:8000"
	@echo "Press Ctrl+C to stop the server"
	@if command -v python3 >/dev/null 2>&1; then \
		python3 -m http.server 8000; \
	elif command -v python >/dev/null 2>&1; then \
		python -m http.server 8000; \
	elif command -v ruby >/dev/null 2>&1; then \
		ruby -run -e httpd . -p 8000; \
	elif command -v php >/dev/null 2>&1; then \
		php -S localhost:8000; \
	else \
		echo "Error: No suitable HTTP server found."; \
		echo "Please install Python, Ruby, or PHP to run a local server."; \
		exit 1; \
	fi

# Install Jekyll (optional, for advanced features)
install:
	@echo "Installing Jekyll and dependencies..."
	@if command -v bundle >/dev/null 2>&1; then \
		bundle install; \
	elif command -v gem >/dev/null 2>&1; then \
		gem install jekyll bundler; \
	else \
		echo "Ruby and Bundler not found. Installing basic dependencies..."; \
		echo "For full Jekyll support, install Ruby first."; \
	fi

# Clean temporary files
clean:
	@echo "Cleaning up temporary files..."
	@rm -rf _site
	@rm -rf .jekyll-cache
	@rm -rf .sass-cache
	@echo "Clean complete!"

# Open blog in browser (works on most systems)
open:
	@echo "Opening blog in browser..."
	@if command -v xdg-open >/dev/null 2>&1; then \
		xdg-open http://localhost:8000; \
	elif command -v open >/dev/null 2>&1; then \
		open http://localhost:8000; \
	elif command -v start >/dev/null 2>&1; then \
		start http://localhost:8000; \
	else \
		echo "Please manually open http://localhost:8000 in your browser"; \
	fi
