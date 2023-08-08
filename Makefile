test:
	rm -rf /tmp/testproject || true
	pdm run cookiecutter . --output-dir /tmp --no-input project_name=testproject
	cd /tmp/testproject && \
	$(MAKE) build VERSION=0.0.0 && \
	$(MAKE) test && \
	docker-compose up -d && \
	until ! (docker-compose ps | grep -q "starting"); do sleep 5; done && \
	! (docker-compose ps | grep -q "unhealthy") && \
	docker compose ps && \
	@echo "All services healthy" && \
	docker-compose down
	@echo "All tests passed"

.PHONY: test
