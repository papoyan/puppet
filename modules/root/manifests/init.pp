class root {

	
        file {"/root/.bash_profile":
                source => "puppet:///modules/root/bash_profile",
                owner => "root",
                group => "root",
                mode => 644,
             }	
}
