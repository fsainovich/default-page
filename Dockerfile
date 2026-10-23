
FROM nginxinc/nginx-unprivileged:1.28-alpine

LABEL org.opencontainers.image.title="Default Web Page"
LABEL org.opencontainers.image.description="Default Web Page - for GatewayAPI"

COPY --chown=1001:1001 nginx.conf /etc/nginx/conf.d/default.conf
COPY --chown=1001:1001 index.html /usr/share/nginx/html/index.html

USER 1001

EXPOSE 8080

HEALTHCHECK --interval=30s \
            --timeout=3s \
            --start-period=5s \
            --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
