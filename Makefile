DOCKER_IMAGE=dockette/plantuml
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64

include VERSION

.PHONY: build
build:
	docker build \
		--build-arg PLANTUML_VERSION=${PLANTUML_VERSION} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: push
push:
	docker buildx build \
		--platform ${DOCKER_PLATFORMS} \
		--build-arg PLANTUML_VERSION=${PLANTUML_VERSION} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		--push \
		.

.PHONY: shell
shell:
	docker run --rm -it --entrypoint /bin/bash ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: test
test: _testcase-version _testcase-render

.PHONY: _testcase-version
_testcase-version:
	docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} -version | grep -F "${PLANTUML_VERSION}"

# Render a sequence diagram and a class diagram (needs Graphviz) to PNG and SVG
.PHONY: _testcase-render
_testcase-render:
	@dir="$$(mktemp -d)"; \
	printf '@startuml\nAlice -> Bob: Hello\nBob --> Alice: Hi\n@enduml\n' > "$$dir/sequence.puml"; \
	printf '@startuml\nclass Animal\nclass Dog\nAnimal <|-- Dog\n@enduml\n' > "$$dir/class.puml"; \
	docker run --rm -v "$$dir":/data ${DOCKER_IMAGE}:${DOCKER_TAG} -tpng sequence.puml class.puml || exit 1; \
	docker run --rm -v "$$dir":/data ${DOCKER_IMAGE}:${DOCKER_TAG} -tsvg sequence.puml class.puml || exit 1; \
	for f in sequence.png sequence.svg class.png class.svg; do \
		test -s "$$dir/$$f" || { echo "missing or empty: $$f"; exit 1; }; \
	done; \
	grep -q Alice "$$dir/sequence.svg" && grep -q Animal "$$dir/class.svg" || { echo "labels missing in svg"; exit 1; }; \
	echo "render ok: png, svg"

.PHONY: version
version:
	@echo ${VERSION}

.PHONY: release
release:
	@sed -i.bak "s/^VERSION=.*/VERSION=$$(date -u +%Y.%m.%d)/" VERSION && rm VERSION.bak
	@cat VERSION
