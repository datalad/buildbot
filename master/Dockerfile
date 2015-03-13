# This file is part of Buildbot configuration for DataLad.
# Distributed under the same license terms as DataLad itself.
FROM debian:jessie

COPY conf/etc/apt/apt.conf.d/99apt-cacher /etc/apt/apt.conf.d/99apt-cacher

RUN apt-get update
# pull in old and new dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
	buildbot npm nodejs python-docker git virtualenv
# Debian renamed it to nodejs... heh heh
RUN ln -s /usr/bin/nodejs /usr/local/bin/node
# purge old version of buildbot itself
RUN dpkg --purge buildbot
RUN apt-get clean

# that one was "in the wrong place in the wrong time"
RUN deluser buildbot
# enforce specific uid/gid so we could use folder shared with the main
# system
RUN groupadd --gid 131 -r buildbot && useradd -m -g buildbot --uid 121 buildbot

USER buildbot
WORKDIR /home/buildbot

RUN git clone git://github.com/datalad/buildbot.git; cd buildbot; git submodule update --init --recursive
RUN virtualenv --system-site-packages buildbot/venv-eight
RUN make -C buildbot install

USER root
# Copy private information
COPY private/* /home/buildbot/buildbot/master/private/
RUN chown buildbot.buildbot -R /home/buildbot/buildbot/master/private/

USER buildbot
# pull is just to help with pushing changes while playing with Dockerfile/setup
RUN cd buildbot; git pull; make prepare-master

EXPOSE :8020
ENTRYPOINT ["/home/buildbot/buildbot/run"]
