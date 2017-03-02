class java {
	
	package { ["java-1.7.0-openjdk"]:
        }

	file { "/usr/lib/jvm/default-java":
                  ensure => link,
                  target => "/usr/lib/jvm/jre-1.7.0-openjdk.x86_64",
        }

}

