#!/bin/sh
 
# Script to enable specified users of SSH on OS X systems

# Implemented : r.purves@arts.ac.uk

# Version 1.0 : 02-08-2013 - Initial Version
# Version 1.1 : 06-08-2013 - Added *redacted* group

# Eventual plan is to remove uadmin ssh access and replace entirely with AD groups.

# Lovingly stolen and modified from https://jamfnation.jamfsoftware.com/discussion.html?id=7741
  
# Check that root is running the script otherwise nothing works
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
 
# Remove the existing SSH access group (revert to all user access)
dseditgroup -o delete -t group com.apple.access_ssh

# Create the access group again anew
dseditgroup -o create -q com.apple.access_ssh

# Add the Casper Management account (very important!)
dseditgroup -o edit -a *redacted* -t user com.apple.access_ssh

# Add the standard local admin management account
dseditgroup -o edit -a *redacted* -t user com.apple.access_ssh

# Add the Casper Support Analysts AD group as a subgroup
dseditgroup -o edit -a "DOMAIN\group1" -t group com.apple.access_ssh

# Add the Casper Lead Engineers AD group as a subgroup
dseditgroup -o edit -a "DOMAIN\group2" -t group com.apple.access_ssh

# Add the Desktop Managers AD group as a subgroup
dseditgroup -o edit -a "DOMAIN\group3" -t group com.apple.access_ssh

# Confirm who's in the group to the Casper logs
dseditgroup -o read -t group com.apple.access_ssh

# Make sure that SSH is enabled
systemsetup -setremotelogin on
 
exit 0
