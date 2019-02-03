FROM bitwalker/alpine-elixir-phoenix:1.7.3 as builder

ENV MIX_ENV=prod HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120

# Copy all files except the ones listed in .dockerignore file
COPY . .

RUN mix local.hex --force && mix local.rebar --force && \
	mix deps.get && \
	mix ecto.create && mix ecto.migrate && \
	mix do deps.get --only prod, deps.compile && \
	cd ./assets && npm install && \
	./node_modules/brunch/bin/brunch b -p

RUN mix phx.digest && \
	mix release --env=prod --verbose

##################### RELEASE ############################

# with this image the workdir is set at /opt/app
FROM bitwalker/alpine-erlang:21.0.3

RUN apk update && \
    apk --no-cache --update add libgcc libstdc++ bash openssh-client imagemagick && \
    rm -rf /var/cache/apk/*

EXPOSE 4000
ENV PORT=4000 MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/sh

COPY --from=builder /opt/app/_build/prod/rel/exrancher/releases/0.0.1/exrancher.tar.gz .
COPY --from=builder main_db .
RUN tar -xzf exrancher.tar.gz && rm exrancher.tar.gz

USER default

ENTRYPOINT ["./bin/exrancher"]