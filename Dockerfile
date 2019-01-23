FROM golang

WORKDIR /go/src/ga-beacon

# Add application code
COPY ga-beacon.go main.go
COPY page.html page.html
COPY static/ static/

# Install dependencies
RUN go get -d -v \
    && go install -v

# Multi-stage build to reduce image size
FROM alpine:latest

COPY --from=0 /go/bin/ga-beacon /usr/local/bin/ga-beacon

ENTRYPOINT [ "ga-beacon" ]
