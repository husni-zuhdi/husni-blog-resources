FROM rust:1.73-buster AS builder
COPY . .
RUN cargo build --release

FROM gcr.io/distroless/cc
# Solve libssl.so.1.1 issue
# RUN apt-get update && apt-get install -y \
#     openssl \
#     libssl-dev \
#     ca-certificates \
# && rm -rf /var/lib/apt/lists/*
COPY --from=builder ./target/release/api /api
CMD ["/api"]
