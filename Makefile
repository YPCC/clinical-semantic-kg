.PHONY: install test lint eval docs clean help

help:
	@echo "Available targets:"
	@echo "  install   - Install dependencies with uv"
	@echo "  test      - Run unit + integration tests"
	@echo "  lint      - Lint and format check"
	@echo "  eval      - Run Agents CLI evaluation"
	@echo "  docs      - Build / serve docs"
	@echo "  clean     - Remove caches and build artifacts"

install:
	uv sync --group dev

test:
	uv run pytest tests/ -q

lint:
	uv run ruff check .
	uv run ruff format --check .

eval:
	@echo "Run: agents-cli evaluate  (or make evaluate via Agents CLI)"

docs:
	@echo "Open docs/ in your editor or serve with mkdocs if configured"

clean:
	rm -rf .pytest_cache .ruff_cache dist build *.egg-info
	find . -type d -name __pycache__ -exec rm -rf {} +
