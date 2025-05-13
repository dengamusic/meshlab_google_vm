FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive \
    XPRA_ALLOW_ROOT=yes          

RUN apt-get update && apt-get install -y --no-install-recommends \
        xpra xvfb                           \
        xserver-xorg-video-dummy xserver-xorg-core     \
        xauth dbus-x11 curl ca-certificates gnupg      \
        meshlab websockify                             \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3-paramiko python3-uinput python3-lz4 lz4 \
        python3-dbus python3-xdg python3-pyinotify python3-pil \
        python3-avahi \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 10011
ENTRYPOINT ["/entrypoint.sh"]
