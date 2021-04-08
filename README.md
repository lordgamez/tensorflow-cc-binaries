# Tensorflow CC binaries
This repository provides Dockerfile for building [tensorflow_cc](https://github.com/FloopCZ/tensorflow_cc) project and storing the Tensorflow and Google Protobuf libraries and header files in a docker image. The pre-built binaries then can be used for building applications. The image is built on Dockerhub and can be pulled from [lordgamez/tensorflow-cc-binaries](https://hub.docker.com/repository/docker/lordgamez/tensorflow-cc-binaries/).

Currently only binaries for Ubuntu 20.04 are built.

## Usage

The image can be built with the `build_image.sh` shell script or can be pulled from [Docker Hub](https://hub.docker.com/repository/docker/lordgamez/tensorflow-cc-binaries/).

After the image is ready, you can copy the tar.gz file to you local machine by issuing the command `docker run --rm tensorflow-cc-binaries:ubuntu-20.04 > tensorflow-binaries.tar.gz`. After extracting the archive you can find the Tensorflow and Google Protobuf libraries in the `libs` directory, the Tensorflow headers in the `tensorflow_include` directory and the Google Protobuf headers in the `protobuf_include` directory.
