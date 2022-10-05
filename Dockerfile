FROM casjaysdevdocker/nodejs:latest as build

ARG LICENSE=WTFPL \
  IMAGE_NAME=readme-to-dockerhub \
  TIMEZONE=America/New_York \
  NODE_VERSION="14" \
  PORT=

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="${HOSTNAME:-casjaysdev-$IMAGE_NAME}" \
  TZ="$TIMEZONE" \
  NODE_MANAGER="fnm"

RUN mkdir -p /bin/ /config/ /data/ && \
  rm -Rf /bin/.gitkeep /config/.gitkeep /data/.gitkeep && \
  apk update -U --no-cache && \
  apk add --no-cache nodejs && \
  setup_node $NODE_VERSION

COPY ./bin/. /usr/local/bin/
COPY ./config/. /config/
COPY ./data/. /data/
COPY /src/. /app/

WORKDIR /app
RUN npm i

FROM scratch
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')"

LABEL org.label-schema.name="readme-to-dockerhub" \
  org.label-schema.description="Containerized version of readme-to-dockerhub" \
  org.label-schema.url="https://hub.docker.com/r/casjaysdevdocker/readme-to-dockerhub" \
  org.label-schema.vcs-url="https://github.com/casjaysdevdocker/readme-to-dockerhub" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="$LICENSE" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="latest" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>"

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-readme-to-dockerhub" \
  TZ="${TZ:-America/New_York}" \
  PATH="/root/.local/share/fnm/aliases/default/bin:$PATH" \
  NVM_DIR="/root/.nvm"

WORKDIR /app

VOLUME ["/config", "/data"]

EXPOSE $PORT

COPY --from=build /. /

ENTRYPOINT [ "tini", "--" ]
HEALTHCHECK CMD [ "/usr/local/bin/entrypoint-readme-to-dockerhub.sh", "healthcheck" ]
CMD [ "/usr/local/bin/entrypoint-readme-to-dockerhub.sh" ]
