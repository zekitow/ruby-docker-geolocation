#! /bin/bash

echo "[SINTRA DOCKER] Waiting DB to get ready..."
sleep 25

echo "[SINTRA DOCKER] Running RACK_ENV $RACK_ENV"
echo "[SINTRA DOCKER] Setting $APP_HOME"
cd $APP_HOME

echo "[SINTRA DOCKER] Running bundle..."
bundle check || bundle install --binstubs="$BUNDLE_BIN"

echo "[SINTRA DOCKER] Running migrations..."
bundle exec rake db:migrate
bundle exec rake db:seed

echo "[SINTRA DOCKER] Starting puma..."
bundle exec puma -p 3000

echo "[SINTRA DOCKER] Done."