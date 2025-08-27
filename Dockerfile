# Dockerfile
FROM hexpm/elixir:1.15.5-erlang-26.0.2-debian-bullseye-20230612 as build

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix do local.hex --force, local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod
RUN mix deps.compile

# build assets
COPY assets assets
RUN mix assets.deploy

# build project
COPY lib lib
COPY priv priv
RUN mix compile

# build release
RUN mix release

# start a new build stage
FROM debian:bullseye-20230612

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

WORKDIR /app
COPY --from=build /app/_build/prod/rel/my_app ./

CMD ["bin/my_app", "start"]
