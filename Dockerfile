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

ENV	GOROOT=/usr/local/go

ENV	GOPATH=/tmp/go

RUN	gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 \
	&& (\curl -ksSL https://get.rvm.io | bash -s stable --ruby)

ENV	PATH $GOROOT/bin:$GOPATH/bin:/scratch/usr/local/bin:/usr/local/rvm/bin:/usr/local/rvm/rubies/default/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN	gem install fpm --no-rdoc --no-ri

RUN	curl -s -o /tmp/aptly_cli.gem http://download.morph027.de/aptly_cli-0.2.1.gem \
	&& gem install commander httmultiparty --no-ri --no-rdoc \
	&& gem install --local /tmp/aptly_cli.gem \
	&& rm -f /tmp/aptly_cli.gem
