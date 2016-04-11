#FROM multiarch/ubuntu-debootstrap:amd64-xenial # arch=amd64
#FROM multiarch/ubuntu-debootstrap:armhf-xenial # arch=armhf
#FROM multiarch/ubuntu-debootstrap:i368-xenial # arch=i368
ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.23
RUN apt-get -q update \
	&& apt-get -qy install build-essential wget openssl gawk
COPY overlay-common/configparams /glibc-build/configparams
COPY overlay-common/builder /builder
ENTRYPOINT ["/builder"]
