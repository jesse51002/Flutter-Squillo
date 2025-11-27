.PHONY: update-openapi codegen help

# Default target
help:
	@echo "Flutter-Squillo Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  update-openapi  - Fetch and format OpenAPI spec from localhost:8000"
	@echo "  codegen        - Run build_runner to generate code (json_serializable)"
	@echo "  help           - Show this help message"

# Fetch OpenAPI spec from local backend and format it with 2-space indentation
update-openapi:
	@echo "Fetching OpenAPI spec from http://localhost:8000/openapi.json..."
	@curl -s http://localhost:8000/openapi.json | python3 -m json.tool --indent 2 > openapi.json
	@echo "✓ OpenAPI spec updated and formatted in openapi.json"

# Generate code using build_runner (for json_serializable)
codegen:
	@echo "Running build_runner to generate code..."
	@flutter pub get
	@flutter pub run build_runner build --delete-conflicting-outputs
	@echo "✓ Code generation complete"
