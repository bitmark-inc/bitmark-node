FROM bitmark/nodejs-env as build-client

COPY ui /go/src/github.com/bitmark-inc/bitmark-node/ui
RUN cd /go/src/github.com/bitmark-inc/bitmark-node/ui && bash -c "source ~/.nvm/nvm.sh && npm install && npm run build"

FROM bitmark/go-env:go12 as go-env

# VERSION SHOW ON BITMARK-NODE & CHECKOUT
ENV VERSION v1.1.0
ENV BITMARKD_VERSION v0.10.6

# Install argon2 for OS
RUN apt-get install libargon2-0-dev

# Get Bitmarkd and corresponding version
RUN go get -d github.com/bitmark-inc/bitmarkd || \
    cd /go/src/github.com/bitmark-inc/bitmarkd

RUN go get github.com/bitmark-inc/discovery && \
    go get -d github.com/bitmark-inc/bitmark-wallet && \
    go install github.com/bitmark-inc/bitmark-wallet

# Install and build bitmark-cli  bitmark-dumpdb  bitmark-info  bitmarkd  recorderd
ENV GO111MODULE on
RUN cd /go/src/github.com/bitmark-inc/bitmarkd && \
    git checkout "$BITMARKD_VERSION" && \
    go mod download && \
    go install -ldflags "-X main.version=$BITMARKD_VERSION" github.com/bitmark-inc/bitmarkd/command/...

COPY . /go/src/github.com/bitmark-inc/bitmark-node
RUN go install -ldflags "-X main.version=$VERSION" github.com/bitmark-inc/bitmark-node
COPY --from=build-client /go/src/github.com/bitmark-inc/bitmark-node/ui/public/ /go/src/github.com/bitmark-inc/bitmark-node/ui/public/

RUN cd /go/src/github.com/bitmark-inc/bitmark-node && \
    go mod download && \
    go install -ldflags "-X main.version=$VERSION" github.com/bitmark-inc/bitmark-node

ENV GO111MODULE off

# COPY static ui to bitmark-node
COPY --from=build-client /go/src/github.com/bitmark-inc/bitmark-node/ui/public/ /go/src/github.com/bitmark-inc/bitmark-node/ui/public/

ADD bitmark-node.conf.sample /.config/bitmark-node/bitmark-node.conf
ADD docker-assets/bitmarkd.conf /.config/bitmark-node/bitmarkd/bitmark/
ADD docker-assets/recorderd.conf /.config/bitmark-node/recorderd/bitmark/
ADD docker-assets/bitmarkd-test.conf /.config/bitmark-node/bitmarkd/testing/bitmarkd.conf
ADD docker-assets/recorderd-test.conf /.config/bitmark-node/recorderd/testing/recorderd.conf
ADD docker-assets/start.sh /

ENV NETWORK bitmark

EXPOSE 2130 2131 2135 2136
CMD ["/start.sh"]
