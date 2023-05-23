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

CMD_PREFIX="flutter build web --web-renderer html --release"
CMD_PARAMS=""
for var in ${DART_DEFINES_PARAMS[@]}; do
  CMD_PARAMS="$CMD_PARAMS --dart-define=\"$(eval echo $var=\$$var)\""
done
CMD="$CMD_PREFIX$CMD_PARAMS $PLATFORM_SPECIFIC_PARAMS"

# Build the app
echo "$CMD"
eval "$CMD"

# Modify the index.html to add the version and date
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s|main.dart.js|main.dart.js?v=$VERSION-$DATE|g" build/web/index.html
  sed -i '' "s|.png|.png?v=$VERSION-$DATE|g" build/web/index.html
  sed -i '' "s|.ico|.ico?v=$VERSION-$DATE|g" build/web/index.html
  sed -i '' "s|.jpg|.jpg?v=$VERSION-$DATE|g" build/web/index.html
  sed -i '' "s|.jpeg|.jpeg?v=$VERSION-$DATE|g" build/web/index.html
else
  # Otherwise, use sed -i to replace the version in place
  sed -i "s|main.dart.js|main.dart.js?v=$VERSION-$DATE|g" build/web/index.html
  sed -i "s|.png|.png?v=$VERSION-$DATE|g" build/web/index.html
  sed -i "s|.ico|.ico?v=$VERSION-$DATE|g" build/web/index.html
  sed -i "s|.jpg|.jpg?v=$VERSION-$DATE|g" build/web/index.html
  sed -i "s|.jpeg|.jpeg?v=$VERSION-$DATE|g" build/web/index.html
fi