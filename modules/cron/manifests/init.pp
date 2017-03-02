class cron {
	
	service {"crond":
            ensure  => running,
            enable  => true,
        }


    	cron { ntpupdate:
            command => "/sbin/ntpdate -u 10.99.1.1 > /dev/null 2>&1",
            user => root,
            minute => '*/10',
        }
	
}
	
