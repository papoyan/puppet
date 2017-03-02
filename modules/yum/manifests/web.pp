class yum::web inherits yum {

	file { "/etc/yum.repos.d/varnish3.repo":
                  ensure => file,
                  source => "puppet:///modules/yum/varnish3.repo",
                  owner  => root,
                  group  => root,
                  mode   => 644,
        }

}
