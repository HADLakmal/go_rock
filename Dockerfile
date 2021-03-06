FROM alpine:3.8 as builder

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >>/etc/apk/repositories
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >>/etc/apk/repositories
RUN apk add --update --no-cache build-base linux-headers git cmake bash zlib zlib-dev bzip2 bzip2-dev snappy snappy-dev lz4 lz4-dev zstd@community zstd-dev@community jemalloc jemalloc-dev libtbb-dev@testing libtbb@testing

RUN cd /tmp && \
    git clone https://github.com/gflags/gflags.git && \
    cd gflags && \
    mkdir build && \
    cd build && \
    cmake -DBUILD_SHARED_LIBS=1 -DGFLAGS_INSTALL_SHARED_LIBS=1 .. && \
    make install && \
    cd /tmp && \
    rm -R /tmp/gflags/

RUN cd /tmp && \
    git clone https://github.com/facebook/rocksdb.git && \
    cd rocksdb && \
    git checkout v5.11.3 && \
    make shared_lib && \
    mkdir -p /usr/local/rocksdb/lib && \
    mkdir /usr/local/rocksdb/include && \
    cp librocksdb.so* /usr/local/rocksdb/lib && \
    cp /usr/local/rocksdb/lib/librocksdb.so* /usr/lib/ && \
    cp -r include /usr/local/rocksdb/ && \
    cp -r include/* /usr/include/ && \
    cd .. && \
    rm -rf rocksdb
