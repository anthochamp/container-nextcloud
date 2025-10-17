FROM nextcloud:32.0.0-apache@sha256:3e70e4dfe882ef44738fdc30d9896fb07c12febb27c4a1177e3d63dc0004a0b4

# reconfigure php image (do not output access log to stdout, use production php.ini)
RUN set -ex; \
	rm "/var/log/apache2/access.log"; \
	cp "$PHP_INI_DIR"/php.ini-production "$PHP_INI_DIR"/php.ini;

# hadolint ignore=DL3008
RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends libsmbclient-dev; \
	apt-get install -y --no-install-recommends ffmpeg libreoffice; \
	apt-get install -y --no-install-recommends ghostscript smbclient; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/*

RUN set -ex; \
	pecl channel-update pecl.php.net; \
	pecl install smbclient; \
	docker-php-ext-enable smbclient;

# https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
RUN set -ex; \
	sed 's/domain="coder" rights="none"/domain="coder" rights="read,write"/g' /etc/ImageMagick-7/policy.xml > /etc/ImageMagick-7/policy.xml.tmp; \
	mv /etc/ImageMagick-7/policy.xml.tmp /etc/ImageMagick-7/policy.xml

RUN set -ex; \
	mkdir -p /var/log/nextcloud; \
	ln -sfT /dev/stdout "/var/log/nextcloud/nextcloud.log"; \
	chown -R --no-dereference "www-data:www-data" "/var/log/nextcloud";

COPY --chmod=775 /rootfs/docker-entrypoint-hooks.d /docker-entrypoint-hooks.d

COPY --chmod=775 /rootfs/entrypoint2.sh /

ENTRYPOINT [ "/entrypoint2.sh" ]
CMD ["apache2-foreground"]
