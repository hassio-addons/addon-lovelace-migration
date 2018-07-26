#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Lovelace Migration
# This file takes care of the auto backup of configurations
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly BACKUP_DIR='/backup/lovelace-migration'
readonly CONFIG='/config/ui-lovelace.yaml'
declare backup

# Stop executing when backups are disabled
if hass.config.false 'auto_backups'; then
    hass.log.warning 'Automatic backups are disabled!'
    exit 0
fi

# Ensure backup folder exists
if ! hass.directory_exists "${BACKUP_DIR}"; then
    mkdir -p "${BACKUP_DIR}"
fi

# Backup file if it exists
if hass.file_exists "${CONFIG}"; then
    backup="${BACKUP_DIR}/ui-lovelace-$(date '+%Y-%m-%d-%H.%M.%S').yaml"
    cp "${CONFIG}" "${backup}"

    hass.log.info "Backup of current lovelace UI created!"
    hass.log.info "File: ${backup}"
fi
