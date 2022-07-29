FROM docker:20.10.8-git
RUN wget -q "https://github.com/sigstore/cosign/releases/download/v1.6.0/cosign-linux-amd64" && \
    mv cosign-linux-amd64 /usr/local/bin/cosign && \
    chmod +x /usr/local/bin/cosign
USER nobody