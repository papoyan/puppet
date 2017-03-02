class scripts {

	file {"/opt/vaac/bin/":
                source => "puppet:///modules/scripts/bin/",
		recurse => true,
                owner => "root",
                group => "root",
                mode => 755,
		ensure => directory,
             }

}
