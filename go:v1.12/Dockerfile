FROM damindu/rockdb:v5.11.3

  # Install tools we might need
RUN apk add --update curl

  # Download Go 1.2.2 and install it to /usr/local/go
RUN curl -s https://storage.googleapis.com/golang/go1.12.4.linux-amd64.tar.gz | tar -C /usr/local -xz

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

