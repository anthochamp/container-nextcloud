#!/usr/bin/env sh
set -eu

# gathered from https://github.com/nextcloud/all-in-one/blob/main/Containers/nextcloud/entrypoint.sh
# not in https://github.com/nextcloud/docker/blob/master/28/apache/entrypoint.sh

php /var/www/html/occ maintenance:repair

php /var/www/html/occ db:add-missing-indices
php /var/www/html/occ db:add-missing-columns
php /var/www/html/occ db:add-missing-primary-keys

yes | php /var/www/html/occ db:convert-filecache-bigint
php /var/www/html/occ maintenance:mimetype:update-js
php /var/www/html/occ maintenance:mimetype:update-db
