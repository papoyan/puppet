class webserver {

	include cron
	include admintools
	include root
	include apache::prod
	#include apache::protected_prod
	include java
	include ec2-api-tools
	include ec2-ami-tools
	include scripts
	include postfix
	include yum::web
	include varnish::prod


	file {
    		"/etc/motd":
      		ensure => file,
      		source => "puppet:///modules/webserver/motdweb";
  	}	

	file { "/var/www/html":
                  ensure => link,
                  target => "/opt/vaac/releases/latest_web/",
        }

	file { "/root/.ssh":
                  ensure => directory,
                  owner  => root,
		  group  => root,
		  mode   => 700,
        }

	file { "/root/.ssh/id_rsa":
                  ensure => file,
                  source => "puppet:///modules/webserver/keys/id_rsa",
 		  owner  => root,
		  group  => root,
		  mode   => 600,
        }

	file { "/root/.ssh/id_rsa.pub":
                  ensure => file,
                  source => "puppet:///modules/webserver/keys/id_rsa.pub",
 		  owner  => root,
		  group  => root,
		  mode   => 600,
        }

}
