class apache::protected_prod inherits apache {

	file { "/etc/httpd/conf/httpd.conf":
                  ensure => file,
                  source => "puppet:///modules/apache/conf/httpd.conf.protected_prod",
 		  owner  => root,
		  group  => root,
		  mode   => 644,
        }	


	file { "/etc/httpd/conf.d/.htpass":
                  ensure => file,
                  source => "puppet:///modules/apache/conf/htpass.prod",
 		  owner  => root,
		  group  => root,
		  mode   => 644,
        }	



}
