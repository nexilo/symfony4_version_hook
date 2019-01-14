#!/bin/bash
until [ -f $PROJECT_FILE_PATH ]; do
  (>&2 echo "waiting for source...") && sleep 2
done

until [ -d $PROJECT_VENDOR_PATH ]; do
  (>&2 echo "waiting for vendor...") && sleep 2
done

cd $PROJECT_PATH
bin/console doctrine:migrations:migrate -q
bin/console cache:clear --env=prod
bin/console cache:warmup --env=prod
yarn install || true
yarn run encore production || true

while inotifywait -q -e modify $PROJECT_FILE_PATH >/dev/null; do
    cd $PROJECT_PATH
    bin/console doctrine:migrations:migrate -q
    bin/console cache:clear --env=prod
    bin/console cache:warmup --env=prod
    yarn install || true
    yarn run encore production || true
done
