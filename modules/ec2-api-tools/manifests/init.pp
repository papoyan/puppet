class ec2-api-tools {

	
	file {"/usr/local/bin/ec2-api-tools":
                source => "puppet:///modules/ec2-api-tools/ec2-api-tools",
                recurse => true,
                owner => "root",
                group => "root",
                mode => 755,
		ensure  => directory,
       	     }

}
