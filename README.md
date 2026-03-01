# Rancher Desktop Flatpak

Flatpak package for [Rancher Desktop](https://rancherdesktop.io) — container management and Kubernetes on the desktop.

## Install

### Via Flatpakref (recommended)

```bash
flatpak install https://raw.githubusercontent.com/hanthor/rancher-desktop-flatpak/main/io.rancherdesktop.app.flatpakref
flatpak run io.rancherdesktop.app
```

This installs from the live repository hosted on GitHub Pages, keeping the initial download small and enabling delta updates.

### Via Pre-built Bundle

Download the latest bundle built from `main`:

```bash
wget https://nightly.link/hanthor/rancher-desktop-flatpak/workflows/build/main/rancher-desktop-flatpak.zip
unzip rancher-desktop-flatpak.zip
flatpak --user install io.rancherdesktop.app.flatpak -y
flatpak run io.rancherdesktop.app
```

## Build Locally

### Prerequisites

- **`just`**: Command runner (e.g., `dnf install just` or `apt install just`).
- **`flatpak-builder`**: Required to build. If not installed natively, `just` will automatically use the Flatpak version (`org.flatpak.Builder`).

### Commands

| Command | Description |
|---|---|
| `just deps` | Install Flatpak SDK and runtime dependencies |
| `just build` | Build the Flatpak into `build-dir/` |
| `just install` | Build and install locally (user install) |
| `just run` | Run the installed Flatpak |
| `just clean` | Remove build artifacts |

## CI

A GitHub Actions workflow builds the Flatpak on every push to `main` and on pull requests. On pushes to `main`, the OSTree repository is automatically deployed to GitHub Pages (used by the `.flatpakref`). On PRs, a bot comment is posted with bundle install instructions.

## Updating to a New Release

1. Update the `url` in `io.rancherdesktop.app.yml` to the new release zip.
2. Update the `sha256` hash (`sha256sum` on the downloaded zip).
3. Update `io.rancherdesktop.app.metainfo.xml` with a new release entry.

## Sandbox Considerations

Rancher Desktop runs Linux VMs via Lima/QEMU and needs access to:

- **`/dev/kvm`** — hardware-accelerated virtualization
- **`/sys/module`** — nested virtualization detection (`kvm_amd`/`kvm_intel`)
- **`~/.rd/bin`** — CLI tools (`docker`, `nerdctl`, `kubectl`, `helm`) are symlinked here at runtime; add to your host `$PATH`
- **Container runtime sockets** — Docker and Podman sockets on the host

See [upstream issue #9691](https://github.com/rancher-sandbox/rancher-desktop/issues/9691).
