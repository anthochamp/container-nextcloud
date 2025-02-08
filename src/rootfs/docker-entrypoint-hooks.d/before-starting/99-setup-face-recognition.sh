#!/usr/bin/env sh
set -eu

FACERECOGNITION_PORT=${FACERECOGNITION_PORT:-5000}
FACERECOGNITION_MAX_MEMORY=${FACERECOGNITION_MAX_MEMORY:-536870912}

if [ -n "${FACERECOGNITION_HOST:-}" ]; then
	# https://github.com/matiasdelellis/facerecognition/blob/master/README.md
	php /var/www/html/occ config:system:set facerecognition.external_model_url --value "$FACERECOGNITION_HOST${FACERECOGNITION_PORT:+:$FACERECOGNITION_PORT}"
	if [ -n "${FACERECOGNITION_API_KEY:-}" ]; then
		php /var/www/html/occ config:system:set facerecognition.external_model_api_key --value "$FACERECOGNITION_API_KEY"
	fi
	php /var/www/html/occ face:setup -m 5
	php /var/www/html/occ face:setup -M "$FACERECOGNITION_MAX_MEMORY"
	php /var/www/html/occ config:app:set facerecognition analysis_image_area --value 4320000
	php /var/www/html/occ config:system:set enabledFaceRecognitionMimetype 0 --value image/jpeg
	php /var/www/html/occ config:system:set enabledFaceRecognitionMimetype 1 --value image/png
	php /var/www/html/occ config:system:set enabledFaceRecognitionMimetype 2 --value image/heic
	php /var/www/html/occ config:system:set enabledFaceRecognitionMimetype 3 --value image/tiff
	php /var/www/html/occ config:system:set enabledFaceRecognitionMimetype 4 --value image/webp

	php /var/www/html/occ face:background_job --defer-clustering &
fi
