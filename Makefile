#!/usr/bin/make

BUILDBOT_SRC_DIR=$(CURDIR)/3rd/buildbot
VENV=venv-eight

run-master:
	{ set -e; . $(VENV)/bin/activate; cd $(CURDIR)/master; \
    buildbot start --nodaemon; }

prepare-master:
	{ set -e; . $(VENV)/bin/activate; cd $(CURDIR)/master; \
	buildbot upgrade-master $(CURDIR)/master; }

reconfig-master:
	{ set -e; . $(VENV)/bin/activate; cd $(CURDIR)/master; buildbot reconfig; }

install:
	{ set -e; \
		. $(VENV)/bin/activate; \
		pip install txgithub; \
		cd $(BUILDBOT_SRC_DIR)/master; pip install .; \
	}

run-master-docker:
	docker run -d -p 8020:8020 -p 9989:9989 -v $(CURDIR)/:/home/buildbot/buildbot/ datalad/buildbot:master-0.9 >| master.id

stop-master-docker:
	cat master.id | xargs docker stop
	rm -f master/twistd.pid

start-master-docker:
	cat master.id | xargs docker start

build-docker-master:
	echo "TODO: provide recipe for building master docker images"
	exit 1

build-docker-slaves:
	cd slaves/ && ./build
