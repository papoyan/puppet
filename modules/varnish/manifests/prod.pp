class varnish::prod inherits varnish {

	file { "/etc/default/varnish":
                  ensure => file,
                  source => "puppet:///modules/varnish/conf/varnish.default.prod",
 		  owner  => root,
		  group  => root,
		  mode   => 644,
        }	

	file { "/etc/sysconfig/varnish":
                  ensure => file,
                  source => "puppet:///modules/varnish/conf/varnish.sysconfig.prod",
 		  owner  => root,
		  group  => root,
		  mode   => 644,
        }	


	file { "/etc/varnish/default.vcl":
                  ensure => file,
                  source => "puppet:///modules/varnish/vcl/default.vcl.prod",
 		  owner  => root,
		  group  => root,
		  mode   => 644,
        }	


}
