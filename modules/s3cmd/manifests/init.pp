class s3cmd {

	file {"/usr/bin/s3cmd":
                source => "puppet:///modules/s3cmd/s3cmd",
                owner => "root",
                group => "root",
                mode => 755,
             }


	file {"/root/.s3cfg":
                source => "puppet:///modules/s3cmd/s3cfg",
                owner => "root",
                group => "root",
                mode => 600,
             }


}
