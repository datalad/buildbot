# This file is part of Buildbot configuration for DataLad.
# Distributed under the same license terms as DataLad itself.
FROM debian:jessie

COPY ../slaves/conf/etc/apt/apt.conf.d/99apt-cacher /etc/apt/apt.conf.d/99apt-cacher

RUN apt-get update
# pull in old and new dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	buildbot npm nodejs git virtualenv
# purge old version of buildbot itself
RUN dpkg --purge buildbot
RUN apt-get clean

RUN groupadd -r buildbot && useradd -m -g buildbot buildbot

USER buildbot
RUN git clone git://github.com/datalad/buildbot.git
COPY ../secret buildbot/secret
RUN virtualenv --system-site-packages buildbot/venv
RUN make -C buildbot install

EXPOSE :8010
cmd ["/home/buildbot/buildbot/run", "-n"]
