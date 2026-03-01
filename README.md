# Rancher Desktop Flatpak

Flatpak package for [Rancher Desktop](https://rancherdesktop.io) — container management and Kubernetes on the desktop.

## Building

### Prerequisites

- **`just`**: Command runner (e.g., `dnf install just` or `apt install just`).
- **`flatpak-builder`**: Required to build the package. If not installed natively, `just` will automatically install the Flatpak version (`org.flatpak.Builder`).

```bash
# Install Flatpak SDK and runtime (or let `just deps` handle it)
flatpak install flathub org.freedesktop.Platform//25.08 org.freedesktop.Sdk//25.08
flatpak install flathub org.electronjs.Electron2.BaseApp//25.08
```

### Build

```bash
flatpak-builder --force-clean build-dir io.rancherdesktop.app.yml
```

### Install locally

```bash
flatpak-builder --user --install --force-clean build-dir io.rancherdesktop.app.yml
```

### Run

```bash
flatpak run io.rancherdesktop.app
```

## Updating to a New Release

1. Update the version in the `url` field of `io.rancherdesktop.app.yml`
2. Update the `sha256` hash (compute with `sha256sum` on the downloaded zip)
3. Update `io.rancherdesktop.app.metainfo.xml` with the new release entry

## Notes

### Flatpak Sandbox Considerations

Rancher Desktop runs Linux VMs via Lima/QEMU and needs access to:

- **`/dev/kvm`** — for hardware-accelerated virtualization
- **Host CLI tools** — `docker`, `nerdctl`, `kubectl`, `helm` are accessed via
  `flatpak-spawn --host` (requires `--talk-name=org.freedesktop.Flatpak`)
- **Container runtime sockets** — Docker and Podman sockets on the host

See [upstream issue #9691](https://github.com/rancher-sandbox/rancher-desktop/issues/9691) for
the feature request discussion.
