#!/usr/bin/env bash
set -e

# --- make sure the socket directory exists ---
mkdir -p /run/dbus          # /run == /var/run in Ubuntu

# Start system bus only if it isn't already there
if [ ! -S /run/dbus/system_bus_socket ]; then
    dbus-daemon --system --fork --print-address
fi

# Launch Xpra in the foreground so the container stays alive
exec xpra start \
     --bind-tcp=0.0.0.0:10011 \
     --html=on \
     --daemon=no \
     --exit-with-children \
     --start-child="meshlab"
