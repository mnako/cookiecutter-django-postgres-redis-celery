install:
	poetry install

test:
	poetry run pytest --capture=no --verbose

.PHONY: install test
