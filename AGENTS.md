# AGENTS.md

PlantUML CLI Docker image with Graphviz, published as `dockette/plantuml`.

## Writing style

- Write in ASD-STE100 (Simplified Technical English).
- Follow Zinsser's four principles of quality writing:
  1. Simplicity
  2. Brevity
  3. Clarity
  4. Humanity

## Conventions

- The image is `eclipse-temurin:21-jre` with Graphviz, DejaVu and Noto fonts
  and the plain PlantUML jar in `/opt/plantuml/plantuml.jar`. Keep it that way.
- The jar is the plain `plantuml-<version>.jar` asset of the GitHub release
  (GPL, all features). Do not switch to a `-mit`, `-epl` or other license
  variant without a request.
- The upstream version is pinned in `ARG PLANTUML_VERSION` in the `Dockerfile`.
  The default value must build correctly without any `--build-arg`.
- A PlantUML bump changes `PLANTUML_VERSION` in `VERSION`, the `ARG` default,
  `PLANTUML_SHA256` (from the `digest` of the jar in `gh release view -R
  plantuml/plantuml --json assets`) and the README. The release tag has a
  leading `v`; the Docker tag does not.
- The image runs as root, so it can write output into any mounted `/data`.
- `VERSION` holds the release date and `PLANTUML_VERSION`. `make release` sets
  the date.
- CI builds every branch. Only master is pushed to Docker Hub.
- `make test` checks the version and renders a sequence and a class diagram
  (Graphviz) to PNG and SVG.
- Run `make build test` before you commit.
