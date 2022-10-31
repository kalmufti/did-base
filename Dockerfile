FROM alpine:3.16.2 AS mirror

LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.authors="Khalid Almufti - https://github.com/kalmufti"
LABEL org.opencontainers.image.source="https://github.com/kalmufti/did-base"
LABEL org.opencontainers.image.description="Desktop in Docker - Base Image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --update --no-cache --initdb -p /out \
    alpine-baselayout \
    dbus \
    xvfb \
    novnc \
    tigervnc \
    xfce4 \
    xfce4-terminal \
    adwaita-xfce-icon-theme

# Remove apk residuals
RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache

FROM scratch

ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    HOST_ADDR=localhost

COPY --from=mirror /out/ /
COPY usr/ usr/
COPY xsettings.xml /root/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN mkdir -p /var/lib/dbus
RUN mkdir -p /var/run/dbus

WORKDIR /root

ENTRYPOINT []
CMD ["/usr/bin/app"]
