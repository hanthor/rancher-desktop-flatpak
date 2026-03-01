builder := `command -v flatpak-builder >/dev/null 2>&1 && echo "flatpak-builder" || echo "flatpak run org.flatpak.Builder"`

# Default target: list all available recipes
default:
    @just --list

# Install Flatpak SDK and runtime dependencies
deps:
    flatpak install -y flathub org.freedesktop.Platform//25.08 org.freedesktop.Sdk//25.08
    flatpak install -y flathub org.electronjs.Electron2.BaseApp//25.08
    if ! command -v flatpak-builder >/dev/null 2>&1; then flatpak install -y flathub org.flatpak.Builder; fi

# Build the flatpak
build:
    {{builder}} --force-clean build-dir io.rancherdesktop.app.yml

# Build and install the flatpak locally
install:
    {{builder}} --user --install --force-clean build-dir io.rancherdesktop.app.yml

# Run the installed flatpak
run:
    flatpak run io.rancherdesktop.app

# Clean build artifacts
clean:
    rm -rf build-dir .flatpak-builder
