Set Authorised SSH Users and AD Groups
--------------------------------------

This script is meant to be run at imaging time. As long as the computer is properly bound to the AD, it will happily add the specified local admin account plus a number of AD groups to the allowed SSH user list.

Replace the *redacted* with the local account names.

The AD groups should be replaced in the format "DOMAIN\groupname"
