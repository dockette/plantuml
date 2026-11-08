FROM eclipse-temurin:21-jre

ARG PLANTUML_VERSION=1.2026.9
ARG PLANTUML_SHA256=aa4a1d06f8911c4b842beff4828dd955be431692b631a312d04c0e9fab9581de

# GRAPHVIZ AND FONTS ###########################################################
# Graphviz (dot) lays out class, component and most other diagrams. Without
# fonts, text in PNG output is missing.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        graphviz \
        fonts-dejavu \
        fonts-noto-core && \
    rm -rf /var/lib/apt/lists/*

# PLANTUML #####################################################################
# The plain jar of the release (GPL, all features).
ADD --checksum=sha256:${PLANTUML_SHA256} \
    https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar \
    /opt/plantuml/plantuml.jar
# ADD of a URL is 0600 root.
RUN chmod 0644 /opt/plantuml/plantuml.jar

# The image runs as root: output must be writable in any mounted /data.
WORKDIR /data

ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "/opt/plantuml/plantuml.jar"]

CMD ["-help"]
