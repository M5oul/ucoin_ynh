#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

run_duniter() {
    ynh_exec_as "duniter" duniter --home "$data_dir" "$@"
}

CONFIGURE_DUNITER() {
    run_duniter config --bma --ipv4 127.0.0.1 --port "$port_local_bma" --remoteh $domain --remotep 443 --noupnp

    run_duniter config \
        --ws2p-host 127.0.0.1 --ws2p-port "$port_local_ws2p" \
        --ws2p-remote-host "$domain" --ws2p-remote-port 443 \
        --ws2p-remote-path "/ws2p" --ws2p-noupnp

    # Add BMAS with path, remove auto-generated BMAS endpoint
    run_duniter config --addep "BMAS $domain 443 /bma" --remep "BMAS $domain 443"
}
