#!/usr/bin/env sh
set -eu

if [ -n "${NEXTCLOUD_SERVERINFO_TOKEN:-}" ]; then
	php /var/www/html/occ app:enable serverinfo

	php /var/www/html/occ config:app:set serverinfo token --value "$NEXTCLOUD_SERVERINFO_TOKEN"
fi
