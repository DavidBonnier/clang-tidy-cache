FROM golang:alpine AS builder
WORKDIR /app
ADD . /app
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /tmp/clang-tidy-cache

FROM scratch
COPY --from=builder /tmp/clang-tidy-cache /
ENV PATH="/"
ENTRYPOINT ["./clang-tidy-cache"]
