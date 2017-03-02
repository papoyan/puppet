#!/bin/bash  
git add .  
read -p "Commit description: " desc  
git commit -m "$desc"  
git push origin master


PACKAGE="latest_puppet.tgz"
rm -f /root/$PACKAGE
s3cmd del S3://vreleases/puppet/$PACKAGE
cd /root/
tar czfp $PACKAGE puppet/
s3cmd put /root/$PACKAGE S3://vreleases/puppet/

