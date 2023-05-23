# This script is used to deploy the application to the k8s server.

# We need to have the environment variable set.
if [ -z "$ENV" ]; then
    ENV="prod"
fi

if [ -z "$ECR" ]; then
  echo "❌ No ECR environment variable set."
  exit 1
fi

DATE=$(date +%s)

# Build the image
# docker build  -f deploy/Dockerfile . -t "${IMAGE_NAME}":latest
# docker tag "$IMAGE_NAME:latest" "$ECR:latest"
docker buildx build --platform=linux/amd64 -t "${ECR}:${DATE}-amd64" --build-arg ARCH=amd64/ --load -f deploy/Dockerfile . 
docker buildx build --platform=linux/arm64 -t "${ECR}:${DATE}-arm64" --build-arg ARCH=arm64/ --load -f deploy/Dockerfile . 

echo "Image created: ${ECR}:${DATE}-amd64"
echo "Image created: ${ECR}:${DATE}-arm64"
echo "$IMAGE_PUSH_CMD"
