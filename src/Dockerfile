FROM nextcloud:30-apache@sha256:6456ee9dab40419b9e3349f1a0c46d5764c47a5565fe2a105cd2b5f6ea77dbe5

# reconfigure php image (do not output access log to stdout, use production php.ini)
RUN set -ex; \
	rm "/var/log/apache2/access.log"; \
	cp "$PHP_INI_DIR"/php.ini-production "$PHP_INI_DIR"/php.ini;

# hadolint ignore=DL3008
RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends libsmbclient-dev; \
	apt-get install -y --no-install-recommends ffmpeg libreoffice; \
	apt-get install -y --no-install-recommends ghostscript; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/*

RUN set -ex; \
	pecl channel-update pecl.php.net; \
	pecl install smbclient; \
	docker-php-ext-enable smbclient;

# https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
# ghostscript version on bookworm is 10.0
RUN set -ex; \
	sed 's/domain="coder" rights="none"/domain="coder" rights="read,write"/g' /etc/ImageMagick-6/policy.xml > /etc/ImageMagick-6/policy.xml.tmp; \
	mv /etc/ImageMagick-6/policy.xml.tmp /etc/ImageMagick-6/policy.xml

RUN set -ex; \
	mkdir -p /var/log/nextcloud; \
	ln -sfT /dev/stdout "/var/log/nextcloud/nextcloud.log"; \
	chown -R --no-dereference "www-data:www-data" "/var/log/nextcloud";

COPY --chmod=775 /rootfs/docker-entrypoint-hooks.d /docker-entrypoint-hooks.d

COPY --chmod=775 /rootfs/entrypoint2.sh /

ENTRYPOINT [ "/entrypoint2.sh" ]
CMD ["apache2-foreground"]
