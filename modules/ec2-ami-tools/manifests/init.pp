class ec2-ami-tools {

	
	file {"/usr/local/bin/ec2-ami-tools":
                source => "puppet:///modules/ec2-ami-tools/ec2-ami-tools",
                recurse => true,
                owner => "root",
                group => "root",
                mode => 755,
		ensure  => directory,
       	     }

}
