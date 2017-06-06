FROM nicoinn/rpi-raspbian-qemu:latest

RUN [ "cross-build-start" ]

RUN apt-get update \
	&& apt-get install -y --no-install-recommends curl `cat /apt_packages.list | awk -F'\t'  '($1!~/^#/) && ($1!~/^$/) {print $1}' ` \
	&& curl -O http://downloads.slimdevices.com/LogitechMediaServer_v7.9.0/logitechmediaserver_7.9.0_arm.deb \
	&& dpkg -i logitechmediaserver_7.9.0_arm.deb && rm -rf logitechmediaserver_7.9.0_arm.deb \
	&& apt-get remove -y curl \
	&& apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*



#Do something here :)

RUN [ "cross-build-end" ]  
