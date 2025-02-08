#!/usr/bin/env sh
set -eu

if [ -n "${NEXTCLOUD_AUDIT_LOG:-}" ]; then
	auditLog=
	if grep '^/' "$NEXTCLOUD_AUDIT_LOG"; then
		auditLog=$NEXTCLOUD_AUDIT_LOG
	else
		auditLog="/var/log/nextcloud/$NEXTCLOUD_AUDIT_LOG"
	fi

	php /var/www/html/occ app:enable admin_audit
	php /var/www/html/occ config:app:set admin_audit logfile --value="$auditLog"
	php /var/www/html/occ config:system:set log.condition apps 0 --value="admin_audit"
else
	php /var/www/html/occ app:disable admin_audit
fi
