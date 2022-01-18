dev-env:
	@if [ ! -d "__pypackages__" ]; then pdm install; pdm install --group dev; fi;

test:
	pdm run pytest --verbose tests

rm:
	rm -rf .mypy_cache/ || true
	rm -rf .pytest_cache/ || true
	rm -rf __pypackages__/ || true
	rm -rf tests/__pycache__/ || true

.PHONY: install test rm
