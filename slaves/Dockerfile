FROM neurodebian:jessie

MAINTAINER Yaroslav Halchenko <yoh@datalad.org>

USER root

# Speed up installation using our apt cacher
#RUN mkdir /etc/apt/apt.conf.d/
COPY conf/etc/apt/apt.conf.d/99apt-cacher /etc/apt/apt.conf.d/99apt-cacher
# might interfer later with the testing, so -- disable
# ENV http_proxy http://172.17.42.1:3128

RUN apt-get update && apt-get install -y -q \
   python-dev \
   python-pip
RUN pip install buildbot-slave
RUN groupadd -r buildbot && useradd -r -g buildbot buildbot
RUN mkdir /buildslave && chown buildbot:buildbot /buildslave

# Assure popcon doesn't kick in
RUN bash -c "echo 'debconf debconf/frontend select noninteractive' | debconf-set-selections -"
# Install datalad dependencies
RUN apt-get install -y -q git-annex python-git python-bs4 patool python-testtools python-mock python-joblib

USER buildbot
WORKDIR /buildslave
RUN buildslave create-slave . 172.17.42.1 nd80 alis212
ENTRYPOINT ["/usr/local/bin/buildslave"]
CMD ["start", "--nodaemon"]
