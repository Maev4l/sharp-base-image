ARG NODE_VERSION=22.17.1
ARG SHARP_VERSION=0.33.0
ARG FUNCTION_DIR="/function"

FROM node:${NODE_VERSION}-bookworm-slim AS build
# Install build dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    unzip \
    libcurl4-openssl-dev \
    python3 \
    python3-pip \
    build-essential \
    autoconf \
    libtool

# Include global arg in this stage of the build
ARG SHARP_VERSION
ARG FUNCTION_DIR
RUN mkdir -p ${FUNCTION_DIR}
WORKDIR ${FUNCTION_DIR}
RUN npm install --cpu=arm64 --os=linux sharp@${SHARP_VERSION}

FROM node:${NODE_VERSION}-bookworm-slim

# Include global arg in this stage of the build
ARG FUNCTION_DIR
RUN mkdir -p ${FUNCTION_DIR}
WORKDIR ${FUNCTION_DIR}
COPY --from=build ${FUNCTION_DIR} ${FUNCTION_DIR}
