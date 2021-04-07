FROM ubuntu:20.04 AS build_image

RUN apt update && apt install -y git
RUN git clone https://github.com/FloopCZ/tensorflow_cc.git && cd tensorflow_cc && git checkout v2.4.1 && cd / && ./tensorflow_cc/Dockerfiles/install-ubuntu.sh

WORKDIR /
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.9.1/protobuf-cpp-3.9.1.tar.gz && tar -xvf protobuf-cpp-3.9.1.tar.gz && rm protobuf-cpp-3.9.1.tar.gz
RUN cd protobuf-3.9.1 && ./configure && make -j$(nproc) install

RUN mkdir /tensorflow_binaries
RUN cd /tensorflow_binaries && mkdir libs && mkdir protobuf_include && mkdir tensorflow_include
RUN cp /usr/local/lib/libprotobuf-lite.so.20.0.1 /tensorflow_binaries/libs && \
    cp /usr/local/lib/libprotobuf.so.20.0.1 /tensorflow_binaries/libs && \
    cp /usr/local/lib/libprotobuf-lite.a /tensorflow_binaries/libs && \
    cp /usr/local/lib/libprotobuf-lite.la /tensorflow_binaries/libs && \
    cp /usr/local/lib/libprotobuf.la /tensorflow_binaries/libs && \
    cp /usr/local/lib/libprotobuf.a /tensorflow_binaries/libs && \
    cp /usr/local/lib/libtensorflow_cc.so.2 /tensorflow_binaries/libs && \
    cd /tensorflow_binaries/libs && \
    ln -s libprotobuf-lite.so.20.0.1 libprotobuf-lite.so.20 && \
    ln -s libprotobuf-lite.so.20 libprotobuf-lite.so && \
    ln -s libprotobuf.so.20.0.1 libprotobuf.so.20 && \
    ln -s libprotobuf.so.20 libprotobuf.so && \
    cp -R /usr/local/include/tensorflow/bazel-bin/tensorflow/include /tensorflow_binaries/tensorflow_include/ && \
    cp -R /usr/local/include/google/ /tensorflow_binaries/protobuf_include/
RUN cd / && tar -czf tensorflow_binaries.tar.gz tensorflow_binaries/


FROM ubuntu:20.04 AS binaries

RUN mkdir tensorflow-binaries
COPY --from=build_image tensorflow_binaries.tar.gz /

CMD cat /tensorflow_binaries.tar.gz
