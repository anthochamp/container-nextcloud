#!/usr/bin/env sh
set -eu

NEXTCLOUD_TRASHBIN_RETENTION_OBLIGATION=${NEXTCLOUD_TRASHBIN_RETENTION_OBLIGATION:-"auto, 30"}
NEXTCLOUD_VERSIONS_RETENTION_OBLIGATION=${NEXTCLOUD_VERSIONS_RETENTION_OBLIGATION:-"auto, 30"}
NEXTCLOUD_ACTIVITY_EXPIRE_DAYS=${NEXTCLOUD_ACTIVITY_EXPIRE_DAYS:-30}

php /var/www/html/occ config:system:set davstorage.request_timeout --value="$PHP_MAX_TIME" --type=int

php /var/www/html/occ config:system:set loglevel --value=1
php /var/www/html/occ config:system:set log_type --value=file
php /var/www/html/occ config:system:set logfile --value="/var/log/nextcloud/nextcloud.log"
php /var/www/html/occ config:system:set log_rotate_size --value="0"

php /var/www/html/occ config:system:set trashbin_retention_obligation --value="$NEXTCLOUD_TRASHBIN_RETENTION_OBLIGATION"
php /var/www/html/occ config:system:set versions_retention_obligation --value="$NEXTCLOUD_VERSIONS_RETENTION_OBLIGATION"
php /var/www/html/occ config:system:set activity_expire_days --value="$NEXTCLOUD_ACTIVITY_EXPIRE_DAYS"

# Set maintenance window so that no warning is shown in the admin overview
if [ -z "$(php /var/www/html/occ config:system:get maintenance_window_start)" ]; then
	php /var/www/html/occ config:system:set maintenance_window_start --type=int --value=100
fi
