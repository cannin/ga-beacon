FROM golang

WORKDIR /go/src/ga-beacon

# Add application code
COPY ga-beacon.go main.go
COPY page.html page.html
COPY static/ static/

# Install dependencies
RUN go get -d -v \
    && CGO_ENABLED=0 GOOS=linux go install -v

# Multi-stage build to reduce image size
FROM alpine:latest

WORKDIR /ga-beacon

COPY --from=0 /go/bin .
COPY --from=0 /go/src/ga-beacon/page.html page.html
COPY --from=0 /go/src/ga-beacon/static static

ENTRYPOINT [ "./ga-beacon" ]
