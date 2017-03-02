#!/bin/bash

S3BUCKET='s3://vreleases/trunk/latest_web.tgz'
REPO='git@github.com:hmvstan/vaac_web.git'

checkout_github() {
	rm -rf /tmp/web_git
        mkdir /tmp/web_git
        cd /tmp/web_git
	git clone $REPO
}

create_archive() {
	cd /tmp/web_git/vaac_web
	tar czfp /tmp/web_git/latest_web.tgz *
}

upload_to_s3() {
	s3cmd put /tmp/web_git/latest_web.tgz $S3BUCKET
}

checkout_github

create_archive

upload_to_s3
