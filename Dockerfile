# syntax=docker/dockerfile:1
# check=error=true
#
# This Dockerfile is designed for production, not development.

ARG RUBY_VERSION=3.4.6
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rack app lives here
WORKDIR /app

# Update gems and bundler
RUN gem update --system --no-document && \
  gem install -N bundler

ENV RACK_ENV="production" \
  BUNDLE_DEPLOYMENT="1" \
  BUNDLE_PATH="/usr/local/bundle" \
  BUNDLE_WITHOUT="development:test"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  rm -f /etc/apt/apt.conf.d/docker-clean && \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' >/etc/apt/apt.conf.d/keep-cache && \
  apt-get update -qq && \
  apt-get install --no-install-recommends -y build-essential git && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock .ruby-version ./
RUN --mount=type=cache,sharing=locked,target=/srv/vendor \
  bundle config set app_config .bundle && \
  bundle config set path /srv/vendor && \
  bundle install && \
  bundle clean && \
  mkdir -p vendor && \
  bundle config set path vendor && \
  cp -ar /srv/vendor .

# Copy application code
COPY . .

# Final stage for app image
FROM base

# Run and own the application files as a non-root user for security
RUN groupadd --system --gid 1000 ruby && \
  useradd ruby --uid 1000 --gid 1000 --create-home --shell /bin/bash
USER ruby:ruby

# Copy built artifacts: gems, application
COPY --chown=ruby:ruby --from=build /usr/local/bundle /usr/local/bundle
COPY --chown=ruby:ruby --from=build /app /app

ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Start the server
EXPOSE 8080
CMD ["server"]
