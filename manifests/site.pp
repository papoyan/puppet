node default {

	case $ec2_tag_role {
        	web: { include webserver }
        	ops:  { include opsserver  }
        	default: { fail("Unrecognized role") }
    	}

}

