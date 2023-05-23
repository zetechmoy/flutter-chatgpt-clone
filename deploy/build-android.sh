#!/bin/bash
# This script build the cities-admin in function of given parameters.

# If environment is not given, use default "prod"
if [ -z "$ENV" ]; then
  ENV="prod"
fi

if [ -z "$AUTH_METHOD" ]; then
  AUTH_METHOD="Basic"
fi

if [ -z "$OPEN_AI_KEY" ]; then
  echo "❌ No OPEN_AI_KEY environment variable set."
  exit 1
fi

if [ -z "$BASE_URL" ]; then
  echo "❌ No BASE_URL environment variable set."
  exit 1
fi

VERSION=$(git rev-parse --short HEAD)
DATE=$(date +%s)

DART_DEFINES_PARAMS=("ENV" "OPEN_AI_KEY" "BASE_URL" "AUTH_METHOD")

CMD_PREFIX="flutter build apk"
CMD_PARAMS=""
for var in ${DART_DEFINES_PARAMS[@]}; do
  CMD_PARAMS="$CMD_PARAMS --dart-define=\"$(eval echo $var=\$$var)\""
done
CMD="$CMD_PREFIX$CMD_PARAMS $PLATFORM_SPECIFIC_PARAMS"

# Build the app
echo "$CMD"
eval "$CMD"