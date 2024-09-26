FROM golang:1.22-bookworm@sha256:5c56bd47228dd572d8a82971cf1f946cd8bb1862a8ec6dc9f3d387cc94136976 as builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY main.go ./
RUN CGO_ENABLED=0 go build -v -o server

FROM gcr.io/distroless/static-debian11@sha256:d27f8df264c425579aaf8d996ddbf65db6c6dc1ef8deeea8c1b7b69b2ebddf02
WORKDIR /app
COPY --from=builder /app/server /app/server
CMD ["/app/server"]