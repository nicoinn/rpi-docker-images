FROM nicoinn/rpi-raspbian-qemu:latest

RUN [ "cross-build-start" ]

COPY apt_packages.list /

RUN apt-get update \
	&& apt-get install -y --no-install-recommends `cat /apt_packages.list | awk -F'\t'  '($1!~/^#/) && ($1!~/^$/) {print $1}' ` \
	&& apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/mikebrady/shairport-sync.git

RUN cd shairport-sync \
	&& autoreconf -i -f \
	&& ./configure --with-alsa --with-avahi --with-ssl=openssl \
	&& make

CMD  /bin/bash

RUN [ "cross-build-end" ]  
