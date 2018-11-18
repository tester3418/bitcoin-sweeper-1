FROM ubuntu
MAINTAINER Dennis Vink <dennis@drvink.com>

ENV VERSION 3.2.3

# Install packages
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential automake pkg-config \
           libtool libffi-dev libgmp-dev python3-dev libsecp256k1-dev curl python3 python3-pip python3-setuptools ruby jq \
	&& curl -o /tmp/Electrum-${VERSION}.tar.gz https://download.electrum.org/${VERSION}/Electrum-${VERSION}.tar.gz \
	&& pip3 install /tmp/Electrum-${VERSION}.tar.gz \
	&& test -f /usr/local/bin/electrum


# Add user
RUN useradd -d /home/user -m user \
	&& mkdir /electrum \
	&& ln -s /electrum /home/user/.electrum \
	&& chown user:user /electrum

USER user
ENV HOME /home/user
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
WORKDIR /home/user
ADD sweeper.rb /home/user/

CMD [ "ruby", "/home/user/sweeper.rb" ]

# Make imports passwordless
USER root
RUN sed -i'' -e's/import getpass/return None/' /usr/local/bin/electrum
USER user
