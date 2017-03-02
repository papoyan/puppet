class apache {

	package { ["httpd",
                   "httpd-tools"]:
        }


	file {["/var/log/httpd"]:
		ensure => directory,
		owner => root,
		group => root,
	}
	
#	service { "httpd":
#		ensure => running,
#		hasstatus => true,
#		hasrestart => true,
#		pattern => "httpd"
#	}

}
