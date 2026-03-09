FROM hexpm/elixir:1.17.3-erlang-27.2-debian-bookworm-20241202-slim

RUN apt-get update -y && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force

ENV MIX_ENV=dev

COPY mix.exs mix.lock ./
RUN mix deps.get

COPY config config
COPY lib lib
COPY dev dev
COPY assets assets
COPY storybook storybook
COPY priv priv

RUN mix assets.setup && mix assets.build
RUN mix compile

EXPOSE 8080

CMD ["mix", "phx.server"]
