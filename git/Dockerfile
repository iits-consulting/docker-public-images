FROM alpine:3.13.6
RUN apk --update --no-cache add git=2.30.2-r0 less=563-r0 openssh=8.4_p1-r3 && \
    rm -rf /var/lib/apt/lists/*
VOLUME /git
WORKDIR /git
USER nobody