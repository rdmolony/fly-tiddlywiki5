# syntax = docker/dockerfile:1

# Adjust NODE_VERSION as desired
ARG NODE_VERSION=20.12.2
FROM node:${NODE_VERSION}-slim as base

LABEL fly_launch_runtime="Node.js"

# Node.js app lives here
WORKDIR /app

# Set production environment
ENV NODE_ENV="production"


# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential node-gyp pkg-config python-is-python3

# Install node modules
COPY package-lock.json package.json ./
RUN npm install -g tiddlywiki


# Final stage for app image
FROM base

# Copy built application
COPY --from=build /usr/local/bin/ /usr/local/bin/
COPY --from=build /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
COPY --from=build /app /app

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD tiddlywiki /data/tiddlers/ --listen host=0.0.0.0 port=3000 username=$TWUSER password=$TWPASS
