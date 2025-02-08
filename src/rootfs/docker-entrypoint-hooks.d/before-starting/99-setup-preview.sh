#!/usr/bin/env sh
set -eu

# https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#enabledpreviewproviders
NEXTCLOUD_PREVIEW_PROVIDERS=${NEXTCLOUD_PREVIEW_PROVIDERS:-"BMP GIF JPEG Krita MarkDown MP3 OpenDocument PNG TXT XBitmap Font HEIC Movie PDF Photoshop Postscript SVG TIFF EMF"}
NEXTCLOUD_PREVIEW_MAX_MEMORY=${NEXTCLOUD_PREVIEW_MAX_MEMORY:-536870912}

if [ "$NEXTCLOUD_PREVIEW_MAX_MEMORY" -gt "$PHP_MEMORY_LIMIT" ]; then
	echo "Capping NEXTCLOUD_PREVIEW_MAX_MEMORY to $PHP_MEMORY_LIMIT due to PHP_MEMORY_LIMIT"
	NEXTCLOUD_PREVIEW_MAX_MEMORY=$PHP_MEMORY_LIMIT
fi

IMAGINARY_PORT=${IMAGINARY_PORT:-9000}

php /var/www/html/occ config:system:delete enabledPreviewProviders
php /var/www/html/occ config:system:set enable_previews --value=true --type=boolean
previewProviderIndex_imaginary=0
previewProviderIndex_custom=10

php /var/www/html/occ config:system:set preview_max_memory --value="$NEXTCLOUD_PREVIEW_MAX_MEMORY" --type=int

if [ -n "${IMAGINARY_URL:-}" ]; then
	php /var/www/html/occ config:system:set preview_imaginary_url --value="$IMAGINARY_URL"
	if [ -n "${IMAGINARY_KEY:-}" ]; then
		php /var/www/html/occ config:system:set preview_imaginary_key --value="$IMAGINARY_KEY"
	fi

	php /var/www/html/occ config:system:set enabledPreviewProviders $previewProviderIndex_imaginary --value="OC\\Preview\\Imaginary"
else
	php /var/www/html/occ config:system:delete preview_imaginary_url
	php /var/www/html/occ config:system:delete preview_imaginary_key
fi

customProviderIndex=$previewProviderIndex_custom
for provider in ${NEXTCLOUD_PREVIEW_PROVIDERS:-}; do
	php /var/www/html/occ config:system:set enabledPreviewProviders ${customProviderIndex} --value="OC\\Preview\\$provider"
	customProviderIndex=$((customProviderIndex + 1))
done
