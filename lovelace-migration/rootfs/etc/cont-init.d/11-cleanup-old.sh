#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Lovelace Migration
# Removes the current Lovelace UI configuration before starting
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG='/config/ui-lovelace.yaml'

# Remove old UI before migration, to prevent other "backup" things triggering.
if hass.file_exists "${CONFIG}"; then
    rm -f "${CONFIG}"
fi
