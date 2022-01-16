default: help

.PHONY: help
help:
	# Usage:
	@sed -n '/^\([a-z][^:]*\).*/s//    make \1/p' $(MAKEFILE_LIST)

.PHONY: backend/install
backend/install:
	cd backend; \
	python3 -m venv env; \
	source env/bin/activate; \
	pip install -r requirements.txt; \

.PHONY: backend/test
backend/test:
	cd backend; \
	source env/bin/activate; \
	python -m unittest; \

.PHONY: backend/run
backend/run:
	cd backend; \
	source env/bin/activate; \
	python -m matchpredictor; \

.PHONY: frontend/test
frontend/test:
	npm --prefix frontend test

.PHONY: frontend/install
frontend/install:
	npm --prefix frontend install

.PHONY: frontend/run
frontend/run:
	npm --prefix frontend start

.PHONY: integration/install
integration/install:
	npm --prefix integration-tests install

.PHONY: integration/test
integration/test:
	cd integration-tests; \
	./run; \

.PHONY: install
install: backend/install frontend/install integration/install

.PHONY: test
test: backend/test frontend/test integration/test
