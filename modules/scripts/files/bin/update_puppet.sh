#!/bin/bash


export JAVA_HOME=/usr/lib/jvm/default-java
export EC2_HOME=/usr/local/bin/ec2-api-tools
export PATH=$PATH:$EC2_HOME/bin
export EC2_CERT="$EC2_HOME/cert-P526RAZM3T7DVBRV5ZEG2WSIALYM452Y.pem"
export EC2_PRIVATE_KEY="$EC2_HOME/pk-P526RAZM3T7DVBRV5ZEG2WSIALYM452Y.pem"
export PATH=$PATH:$HOME/bin:$EC2_HOME/bin:$EC2_AMITOOL_HOME/bin
export AWS_ACCESS_KEY=AKIAIUBY2AWXMSEP5ZLQ
export AWS_SECRET_KEY=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
export EC2_URL=https://ec2.us-west-2.amazonaws.com 



VERSION='latest_web'
WEB_SERVER='54.200.173.21'
PATTERN='VAAC'
LB='172.31.25.199'
TARBALL="s3://vreleases/trunk/$VERSION.tgz"
RELEASE="$VERSION"
PACKAGE="latest_puppet.tgz"
BUCKET="s3://vreleases/puppet/"




upgrade_puppet() {
    #download the manifests
    /bin/rm -rf /root/puppet/
    /bin/mkdir /root/puppet
    /usr/bin/s3cmd --config /root/.s3cfg get $BUCKET$PACKAGE /root/puppet/ --force 2> /var/log/puppet-upgrade-errors.log
    #extract the manifests
    /bin/rm -rf /etc/puppet
    /bin/tar xzf /root/puppet/$PACKAGE -C /etc/

}

apply_rules() {

    /usr/bin/puppet apply --modulepath /etc/puppet/modules /etc/puppet/manifests/site.pp & 2> /var/log/puppet-manifest-errors.log && /etc/init.d/httpd stop && /etc/init.d/varnish stop
}

upgrade_web(){
	rm -rf /root/install/$RELEASE
	mkdir -p /root/install/$RELEASE

	# download artifacts
	/usr/bin/s3cmd -c /root/.s3cfg get $TARBALL /root/install/$RELEASE/ --force

	# extract tarball
	rm -rf /opt/vaac/releases/$RELEASE/
	rm -rf /tmp/$RELEASE
	mkdir -p /opt/vaac/releases/$RELEASE/
        mkdir /tmp/$RELEASE
	tar xzf /root/install/$RELEASE/$RELEASE.tgz -C /tmp/$RELEASE/ 
	mv /tmp/$RELEASE/* /opt/vaac/releases/$RELEASE/ 
        /bin/chown apache:apache -R /opt/vaac/releases/$RELEASE/ 

	# clean up
        rm -rf /root/install
        rm -rf /tmp/$RELEASE
}

block_traffic() {
    /sbin/iptables -A INPUT -s $LB -j DROP	
}

reload_apache() {
    /etc/init.d/httpd reload
}

check_web_unblock_traffic() {

    STATUS=`curl -s http://127.0.0.1/index.html |grep "ARMY" |cut -d ":" -f1|cut -d ">" -f2 |awk {'print $1'}`
    while [ "$STATUS" != "$PATTERN" ]; do
    STATUS=`curl -s http://127.0.0.1/index.html |grep "ARMY" |cut -d ":" -f1|cut -d ">" -f2 |awk {'print $1'}`
        echo 'Release not ready yet. Will try again in 5 seconds.';
        echo $STATUS
        sleep 5;
    done;
    
    echo 'Ready!';
    /sbin/iptables -F 	
}

shutdown_web() {
    /etc/init.d/httpd stop 2>&1
}

start_web() {
    /etc/init.d/httpd start 2>&1
}

shutdown_varnish() {
    /etc/init.d/varnish stop 2>&1
}

start_varnish() {
    /etc/init.d/varnish start 2>&1
}



#shutdown apache
shutdown_varnish

shutdown_web

#block traffic from LB
block_traffic

#update puppet manifests
upgrade_puppet 

#upgrade web release
upgrade_web

#apply puppet manifest
apply_rules 

start_web 

start_varnish 

check_web_unblock_traffic

