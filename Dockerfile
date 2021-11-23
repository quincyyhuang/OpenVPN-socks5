FROM alpine:latest

RUN apk update

# Runtime Dependencies
RUN apk add --no-cache bash openvpn openresolv dumb-init

# Build time dependencies
RUN apk add --no-cache -t .build-deps curl build-base

# Download and build dante
RUN cd /tmp \
  && curl -L https://www.inet.no/dante/files/dante-1.4.3.tar.gz | tar xz \
  && cd dante-* \
  && ac_cv_func_sched_setscheduler=no ./configure --build=$(arch)-unknown-linux \
  && make install

# Clean up
RUN rm -fr /tmp/* \
  && apk del --purge .build-deps

RUN adduser -S -D -H sockd

# Copy Dante conf
COPY sockd.conf /etc/

# scripts for OpenVPN
COPY update-resolv-conf.sh /etc/openvpn/
COPY tun-up.sh /etc/openvpn/
COPY init.sh /root/

RUN chmod +x /etc/openvpn/update-resolv-conf.sh \
  && chmod +x /etc/openvpn/tun-up.sh \
  && chmod +x /root/init.sh

# Expose ports
EXPOSE 1080/tcp
EXPOSE 1080/udp

# Entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/root/init.sh"]