#
# Copyright 2022, kommet.io
#

#! /bin/bash

template_file="subdomain-template"

echo "Deleting old files"
rm sandbox*.conf

# Create 20 subdomains with numbers 001, 002, ..., 020
for i in $(seq -f "%03g" 1 20)
do

	echo "Creating subdomain ${i}"

	subdomain="sandbox${i}"
	newfile="${subdomain}.conf"
	port="9${i}"
	
	# copy the template file replacing domain and port
	sed "s/subdomainname/$subdomain/g" $template_file > $newfile

done

echo "Restarting apache2"
/etc/init.d/apache2 restart
