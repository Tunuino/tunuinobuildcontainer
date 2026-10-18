# syntax=docker/dockerfile:1

FROM ubuntu:24.04
COPY config.sh /config.sh
COPY provide_gcc.sh /provide_gcc.sh

# Shared arduino-cli dirs (IOX firmware/bundle builds): set before config.sh so
# the image build and every later shell - root or not, login or not - use them.
ENV ARDUINO_DIRECTORIES_DATA=/opt/arduino15 \
    ARDUINO_DIRECTORIES_DOWNLOADS=/opt/arduino15/staging \
    ARDUINO_DIRECTORIES_USER=/opt/arduino

RUN /config.sh
RUN arm-none-eabi-gcc --version && arm-none-eabi-objcopy --version
CMD /bin/bash
