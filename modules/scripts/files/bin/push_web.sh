#!/bin/bash  

cd /root/vaac_web
git add .  
read -p "Commit description: " desc  
git commit -m "$desc"  
git push origin master


S3BUCKET='s3://vreleases/trunk/latest_web.tgz'
REPO='git@github.com:hmvstan/vaac_web.git'


create_archive() {
	cd /root/vaac_web
	tar czfp /tmp/latest_web.tgz *
}

upload_to_s3() {
	s3cmd put /tmp/latest_web.tgz $S3BUCKET
}

cleanup() {
rm -f /tmp/latest_web.tgz
}



#checkout_github

create_archive

upload_to_s3

cleanup
