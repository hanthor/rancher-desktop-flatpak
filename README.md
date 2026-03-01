# Rancher Desktop Flatpak

Flatpak package for [Rancher Desktop](https://rancherdesktop.io) — container management and Kubernetes on the desktop.

## Building

### Prerequisites

- **`just`**: Command runner (e.g., `dnf install just` or `apt install just`).
- **`flatpak-builder`**: Required to build the package. If not installed natively, `just` will automatically use the Flatpak version (`org.flatpak.Builder`).

### Quick Start

```bash
# Install all Flatpak runtime dependencies
just deps

# Build the Flatpak
just build

# Build and install locally
just install

# Run the installed Flatpak
just run

# Clean build artifacts
just clean
```

## CI

A GitHub Actions workflow automatically builds the Flatpak on every push to `main` and on pull requests. The built `.flatpak` bundle is uploaded as an artifact. On pull requests, a bot comment is posted with one-click install instructions.

## Updating to a New Release

1. Update the `url` in `io.rancherdesktop.app.yml` to the new release zip.
2. Update the `sha256` hash (`sha256sum` on the downloaded zip).
3. Update `io.rancherdesktop.app.metainfo.xml` with the new release entry.

## Notes

### Flatpak Sandbox Considerations

Rancher Desktop runs Linux VMs via Lima/QEMU and needs access to:

- **`/dev/kvm`** — for hardware-accelerated virtualization
- **`/sys/module`** — for nested virtualization detection (`kvm_amd`/`kvm_intel` parameters)
- **Host CLI tools** — `docker`, `nerdctl`, `kubectl`, `helm` are symlinked into `~/.rd/bin` at runtime; add this to your `$PATH` on the host
- **Container runtime sockets** — Docker and Podman sockets on the host

See [upstream issue #9691](https://github.com/rancher-sandbox/rancher-desktop/issues/9691) for the feature request discussion.
