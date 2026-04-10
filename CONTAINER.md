# Nextcloud Container Images

Container images based on the [official Nextcloud image](https://hub.docker.com/_/nextcloud), a self-hosted file sync and collaboration platform, with additional configuration for previews, face recognition, and audit logging.

Sources are available on [GitHub](https://github.com/anthochamp/container-nextcloud).

See [README.md](README.md) for full documentation and configuration reference.

## Image tags

- `x.y.z-nextcloudA.B.C`: Container image version `x.y.z` with Nextcloud `A.B.C`.
- `edge-nextcloudA.B.C`: Latest commit build with Nextcloud `A.B.C`.

**Tag aliases:**

- `x.y-nextcloudA.B.C`: Latest patch of `x.y` with Nextcloud `A.B.C`.
- `x-nextcloudA.B.C`: Latest minor+patch of `x` with Nextcloud `A.B.C`.
- `x.y.z-nextcloudA.B`: Version `x.y.z` with latest patch of Nextcloud `A.B` (only latest container version updated).
- `x.y-nextcloudA.B`: Latest patch of `x.y` with latest patch of Nextcloud `A.B`.
- `x-nextcloudA.B`: Latest minor+patch of `x` with latest patch of Nextcloud `A.B`.
- `x.y.z-nextcloudA`: Version `x.y.z` with latest minor+patch of Nextcloud `A` (only latest container version updated).
- `x.y-nextcloudA`: Latest patch of `x.y` with latest minor+patch of Nextcloud `A`.
- `x-nextcloudA`: Latest minor+patch of `x` with latest minor+patch of Nextcloud `A`.
- `x.y.z`: Version `x.y.z` with latest Nextcloud (only latest container version updated).
- `x.y`: Latest patch of `x.y` with latest Nextcloud.
- `x`: Latest minor+patch of `x` with latest Nextcloud.
- `nextcloudA.B.C`: Latest container with Nextcloud `A.B.C`.
- `nextcloudA.B`: Latest container with latest patch of Nextcloud `A.B`.
- `nextcloudA`: Latest container with latest minor+patch of Nextcloud `A`.
- `latest`: Latest `x.y.z-nextcloudA.B.C` tag.
- `edge-nextcloudA.B`: Latest commit build with latest patch of Nextcloud `A.B`.
- `edge-nextcloudA`: Latest commit build with latest minor+patch of Nextcloud `A`.
- `edge`: Latest `edge-nextcloudA.B.C` tag.
