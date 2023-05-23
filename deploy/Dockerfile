# To setup multi-arch buildx, see :
# - https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/
# - https://itnext.io/building-multi-cpu-architecture-docker-images-for-arm-and-x86-1-the-basics-2fa97869a99b
# - https://stackoverflow.com/questions/60080264/docker-cannot-build-multi-platform-images-with-docker-buildx
# docker buildx create --use
# docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# docker buildx rm builder
# docker buildx create --name builder --driver docker-container --use
# docker buildx inspect --bootstrap

# Setup for amd64
FROM --platform=linux/amd64 nginx:1.21.6 as stage-amd64

# Setup for arm64
FROM --platform=linux/arm64 arm64v8/nginx:1.21.6 as stage-arm64

# Declare TARGETARCH to make it available
ARG TARGETARCH
ARG AUTH_METHOD
ENV AUTH_METHOD=$AUTH_METHOD
ARG OPEN_AI_KEY
ENV OPEN_AI_KEY=$OPEN_AI_KEY
ARG BASE_URL
ENV BASE_URL=$BASE_URL
# Select final stage based on TARGETARCH ARG
FROM stage-${TARGETARCH} as final

# Container setup
WORKDIR /app

# Load the app
COPY ./build/web /usr/share/nginx/html