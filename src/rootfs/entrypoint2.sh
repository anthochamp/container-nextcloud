#!/usr/bin/env sh
set -eu

export PHP_MEMORY_LIMIT="${PHP_MEMORY_LIMIT:-512M}" # already defined by php image
export PHP_UPLOAD_LIMIT="${PHP_UPLOAD_LIMIT:-512M}" # already defined by php image
export PHP_MAX_TIME="${PHP_MAX_TIME:-1800}"
export APACHE_BODY_LIMIT="${APACHE_BODY_LIMIT:-536870912}"

cat <<EOF >"$PHP_INI_DIR/conf.d/nextcloud.ini"
memory_limit=$PHP_MEMORY_LIMIT
upload_max_filesize=$PHP_UPLOAD_LIMIT
post_max_size=$PHP_UPLOAD_LIMIT
max_execution_time=$PHP_MAX_TIME
max_input_time=$PHP_MAX_TIME
EOF

cat <<EOF >"/etc/apache2/conf-available/apache-limits.conf"
LimitRequestBody $APACHE_BODY_LIMIT
EOF

# avoids smtp password file to be read every single time the config.php is parsed
if [ -n "${SMTP_PASSWORD_FILE:-}" ]; then
	smtpPassword=$(cat -A "$SMTP_PASSWORD_FILE")
	export SMTP_PASSWORD="$smtpPassword"
	unset SMTP_PASSWORD_FILE
fi

exec /entrypoint.sh "$@"
