FROM debian:bookworm-slim

# نصب پیش‌نیازها با apt و تنظیم تایم‌زون تهران
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    bash \
    ca-certificates \
    socat \
    tzdata \
    sqlite3 \
    tar \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# نصب مستقیم نسخه v3.4.2 معماری amd64 (مناسب برای سرورهای Railway)
RUN curl -L "https://github.com/mhsanaei/3x-ui/releases/download/v3.4.2/x-ui-linux-amd64.tar.gz" -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui

RUN mkdir -p /etc/x-ui /var/log/x-ui

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE ${PORT}

CMD ["/start.sh"]
