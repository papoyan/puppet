class apache::prod inherits apache {

	file { "/etc/httpd/conf/httpd.conf":
                  ensure => file,
                  source => "puppet:///modules/apache/conf/httpd.conf.prod",
 		  owner  => root,
		  group  => root,
		  mode   => 644,
        }	
}
