FROM golang

WORKDIR /go/src/ga-beacon

# Add application code
COPY ga-beacon.go main.go
COPY page.html page.html
COPY static/ static/

# Install dependencies
RUN go get -d -v \
    && go install -v

ENTRYPOINT [ "ga-beacon" ]
