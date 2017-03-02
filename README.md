puppet
======

puppet runs on each web server standalone without a puppetmaster. This is to ensure there is no single point of failure.
During the boot process, web server will fetch the latest archive of puppet manifests from S3 bucket. 

How to make changes additions to puppet manifests: 

1. Checkout puppet from github
2. Make the changes
3. use push_puppet.sh script to commit and push the changes to github and update the archive on S3 bucket. 


puppet manifests
