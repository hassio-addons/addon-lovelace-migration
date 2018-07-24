#!/usr/bin/with-contenv bash
# ==============================================================================
#
# Community Hass.io Add-ons: Lovelace Migration
#
# Lovelace Migration add-on for Hass.io.
# This add-on converts your old UI to the new Lovelace UI.
#
# ==============================================================================
set -o errexit  # Exit script when a command exits with non-zero status
set -o errtrace # Exit on error inside any functions or sub-shells
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
    hass.log.trace "${FUNCNAME[0]}"

    output=$(hass.config.get 'output')
    hass.log.info "Output file is set to: ${output}"

    if hass.config.has_value 'init_commands'; then
        while read -r cmd; do
            eval "${cmd}" \
                || hass.die "Failed executing init command: ${cmd}"
        done <<< "$(hass.config.get 'init_commands')"
    fi

    python3 ~/lovelace_migrate.py -o "${output}"

    if hass.config.has_value 'post_commands'; then
        while read -r cmd; do
            eval "${cmd}" \
                || hass.die "Failed executing post command: ${cmd}"
        done <<< "$(hass.config.get 'post_commands')"
    fi
}
main "$@"
