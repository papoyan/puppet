class opsserver {

	include cron
	include admintools
	include root
	include java
	include ec2-api-tools
	include ec2-ami-tools
	include scripts
	include postfix

	file {
    		"/etc/motd":
      		ensure => file,
      		source => "puppet:///modules/opsserver/motdops";
  	}	
	
        file {
    		"/root/.bash_profile":
      		ensure => file,
      		source => "puppet:///modules/opsserver/bash_profile_ops";
		owner  => root,
		group  => root,
                mode   => 644,
	}

}
