#!/usr/bin/make

BUILDBOT_SRC_DIR=$(CURDIR)/3rd/buildbot

run-master:
	{ set -e; . venv/bin/activate; cd $(CURDIR)/master; \
    buildbot start --nodaemon; }

prepare-master:
	{ set -e; . venv/bin/activate; cd $(CURDIR)/master; \
	buildbot upgrade-master $(CURDIR)/master; }

reconfig-master:
	{ set -e; . venv/bin/activate; cd $(CURDIR)/master; buildbot reconfig; }

install:
	{ set -e; \
		. venv/bin/activate; \
		cd $(BUILDBOT_SRC_DIR)/master; pip install .; \
		cd $(BUILDBOT_SRC_DIR); make frontend; \
	}

run-master-docker:
	docker run -p 8010:8010 -p 9989:9989 datalad/buildbot-0.9:0.0.1test2


build-docker-master:
	echo "TODO: provide recipe for building master docker images"
	exit 1

build-docker-slaves:
	cd slaves/ && ./build
