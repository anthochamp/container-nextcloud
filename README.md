# Nextcloud Container Images

![GitHub License](https://img.shields.io/github/license/anthochamp/container-nextcloud?style=for-the-badge)
![GitHub Release](https://img.shields.io/github/v/release/anthochamp/container-nextcloud?style=for-the-badge&color=457EC4)
![GitHub Release Date](https://img.shields.io/github/release-date/anthochamp/container-nextcloud?style=for-the-badge&display_date=published_at&color=457EC4)

Container images based on the [official Nextcloud image](https://hub.docker.com/_/nextcloud), a self-hosted file sync and collaboration platform, extended with configuration for file previews, face recognition, and audit logging.

All environment variables from the [official Nextcloud image](https://github.com/nextcloud/docker#running-this-image-with-docker-compose) are supported. This image extends it with the variables listed below.

## PHP and Apache

| Variable | Default | Description |
| --- | --- | --- |
| `PHP_MEMORY_LIMIT` | `512M` | PHP memory limit per request |
| `PHP_UPLOAD_LIMIT` | `512M` | Maximum upload file size (`upload_max_filesize` and `post_max_size`) |
| `PHP_MAX_TIME` | `1800` | PHP execution and input time limits in seconds (`max_execution_time`, `max_input_time`) |
| `APACHE_BODY_LIMIT` | `536870912` | Apache `LimitRequestBody` in bytes (default: 512 MiB) |

## Retention and cleanup

| Variable | Default | Description |
| --- | --- | --- |
| `NEXTCLOUD_TRASHBIN_RETENTION_OBLIGATION` | `auto, 30` | Trash bin retention policy; see [Nextcloud docs](https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#trashbin-retention-obligation) |
| `NEXTCLOUD_VERSIONS_RETENTION_OBLIGATION` | `auto, 30` | File version retention policy; see [Nextcloud docs](https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#versions-retention-obligation) |
| `NEXTCLOUD_ACTIVITY_EXPIRE_DAYS` | `30` | Number of days before activity log entries are purged |

## File previews

| Variable | Default | Description |
| --- | --- | --- |
| `NEXTCLOUD_PREVIEW_PROVIDERS` | `BMP GIF JPEG Krita MarkDown MP3 OpenDocument PNG TXT XBitmap Font HEIC Movie PDF Photoshop Postscript SVG TIFF EMF` | Space-separated list of enabled preview providers; see [Nextcloud docs](https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#enabledpreviewproviders) |
| `NEXTCLOUD_PREVIEW_MAX_MEMORY` | `536870912` | Maximum memory in bytes allocated to the preview generator (default: 512 MiB) |
| `IMAGINARY_URL` | — | Base URL of an [Imaginary](https://github.com/h2non/imaginary) instance to use for high-performance preview generation; when unset, built-in providers are used |
| `IMAGINARY_KEY` | — | API key for the Imaginary instance, if authentication is enabled |

## Face recognition

When `FACERECOGNITION_HOST` is set, the [Face Recognition](https://github.com/matiasdelellis/facerecognition) app is enabled and configured automatically.

| Variable | Default | Description |
| --- | --- | --- |
| `FACERECOGNITION_HOST` | — | Hostname or IP of the external face recognition model server; when unset, the app is not configured |
| `FACERECOGNITION_PORT` | `5000` | Port of the face recognition model server |
| `FACERECOGNITION_MAX_MEMORY` | `536870912` | Maximum memory in bytes allocated to face recognition (default: 512 MiB) |
| `FACERECOGNITION_API_KEY` | — | API key for the face recognition model server, if authentication is enabled |

## Apps

| Variable | Default | Description |
| --- | --- | --- |
| `NEXTCLOUD_AUDIT_LOG` | — | Enables the `admin_audit` app and sets its log destination; if the value starts with `/` it is used as an absolute path, otherwise it is relative to `/var/log/nextcloud/` |
| `NEXTCLOUD_SERVERINFO_TOKEN` | — | Enables the `serverinfo` app and sets its API token for external monitoring |

## SMTP password (Docker secret)

| Variable | Description |
| --- | --- |
| `SMTP_PASSWORD_FILE` | Path to a file containing the SMTP password; the value is read once at startup and exported as `SMTP_PASSWORD`, avoiding repeated disk reads on every PHP config parse |
