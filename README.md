<h1 align=center>Dockette / PlantUML</h1>

<p align=center>
   🎁 PlantUML command line renderer with Graphviz and fonts.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
  <a href="https://github.com/dockette/plantuml/actions"><img src="https://github.com/dockette/plantuml/actions/workflows/docker.yml/badge.svg"></a>
  <a href="https://hub.docker.com/r/dockette/plantuml/"><img src="https://badgen.net/docker/pulls/dockette/plantuml"></a>
  <a href="https://github.com/sponsors/f3l1x"><img src="https://badgen.net/badge/sponsor/donations/F96854"></a>
  <a href="https://github.com/orgs/dockette/discussions"><img src="https://badgen.net/badge/support/discussions/blue"></a>
</p>

------

[PlantUML](https://plantuml.com) turns text files into UML diagrams. This image runs it from the command line: mount a
folder, pass a `.puml` file, get a PNG or SVG next to it.

## Features

- PlantUML `1.2026.9`, the plain GPL jar of the [release](https://github.com/plantuml/plantuml/releases) with all
  features, verified by SHA-256 at build time
- Graphviz (`dot`) for class, component and most other diagrams
- DejaVu and Noto fonts, so text renders in PNG and SVG
- `eclipse-temurin:21-jre` base, `linux/amd64` and `linux/arm64`
- Working directory is `/data`; the image runs as root so it can write into any mounted folder

## Usage

Render `diagram.puml` to `diagram.png` in the same folder:

```sh
docker run --rm -v "$PWD":/data dockette/plantuml diagram.puml
```

Render to SVG:

```sh
docker run --rm -v "$PWD":/data dockette/plantuml -tsvg diagram.puml
```

Pipe mode, from stdin to stdout:

```sh
docker run --rm -i dockette/plantuml -pipe -tsvg < diagram.puml > diagram.svg
```

Render all files in a folder, or print all options:

```sh
docker run --rm -v "$PWD":/data dockette/plantuml "**/*.puml"
docker run --rm dockette/plantuml -help
```

Files created on Linux hosts are owned by root. Add `--user "$(id -u):$(id -g)"` to use your own user.

## Versions

| Version | Release |
|---------|---------|
| `dockette/plantuml:1.2026.9-YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/plantuml:1.2026.9` | latest release |
| `dockette/plantuml:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/plantuml:latest` | latest build of `master` |

All versions ship PlantUML `1.2026.9`, pinned by `PLANTUML_VERSION` in `VERSION`. The Docker tag has no leading `v`,
unlike the upstream Git tag `v1.2026.9`. Releases are listed on [GitHub](https://github.com/dockette/plantuml/releases).

## Development

```sh
make build          # build the image
make test           # check the version, render PNG and SVG
make shell          # open a shell in the image
make push           # build and push linux/amd64 and linux/arm64
make version        # print VERSION
make release        # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
