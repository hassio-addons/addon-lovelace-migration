#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Lovelace Migration
# Removes the current Lovelace UI configuration before starting
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG='/config/ui-lovelace.yaml'

# Backup file if it exists
if hass.file_exists "${CONFIG}"; then
    rm -f "${CONFIG}"
fi
