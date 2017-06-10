FROM nicoinn/rpi-raspbian-qemu:latest as BUILD_ENV

RUN [ "cross-build-start" ]

#Install required packages for building Shairport-sync
COPY apt_packages_build.list /
RUN apt-get update \
	&& apt-get install -y --no-install-recommends `cat /apt_packages_build.list | awk -F'\t'  '($1!~/^#/) && ($1!~/^$/) {print $1}' ` \
	&& apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

#Clone the Shairport-sync repo
RUN git clone https://github.com/mikebrady/shairport-sync.git

# Compile
RUN cd shairport-sync \
	&& autoreconf -i -f \
	&& ./configure --with-alsa --with-avahi --with-ssl=openssl \
	&& make

RUN [ "cross-build-end" ]  


FROM nicoinn/rpi-raspbian-qemu:latest

RUN [ "cross-build-start" ]


#Install required packages for running Shairport-sync
COPY apt_packages.list /
RUN apt-get update \
        && apt-get install -y --no-install-recommends `cat /apt_packages.list | awk -F'\t'  '($1!~/^#/) && ($1!~/^$/) {print $1}' ` \
        && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=BUILD_ENV /shairport-sync/shairport-sync / 
RUN mkdir /config/

RUN [ "cross-build-end" ]

CMD /shairport-sync -c /config/shairport-sync.conf 


