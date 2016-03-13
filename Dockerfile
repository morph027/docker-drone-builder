FROM ubuntu:trusty

MAINTAINER morph027 "morphsen@gmx.com"

RUN	apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y -qq install \
	build-essential \
	ca-certificates \
	curl \
	dpkg-dev \
	git \
	lsb-release \
	mercurial \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN	cd /tmp \
	&& curl -s -L -O https://storage.googleapis.com/golang/go1.5.3.linux-amd64.tar.gz \
	&& tar -C /usr/local -xzf go1.5.3.linux-amd64.tar.gz \
	&& rm -f go1.5.3.linux-amd64.tar.gz

RUN	cd /tmp \
	&& (curl -s https://raw.githubusercontent.com/drone/drone/master/contrib/setup-sqlite.sh | sh)

RUN	cd /tmp \
	&& (curl -s https://raw.githubusercontent.com/drone/drone/master/contrib/setup-sassc.sh | sh)

RUN	echo "export PATH=\$PATH:/scratch/usr/local/bin" > /etc/profile.d/sqlite.sh

RUN	echo "export GOROOT=/usr/local/go\nexport GOPATH=/tmp/go\nexport PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" > /etc/profile.d/go.sh
