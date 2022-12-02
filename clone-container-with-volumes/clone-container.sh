#
# Copyright 2022, kommet.io
# https://kommet.io
# Distributed under the MIT License
#

#! /bin/bash

# This script creates a new container from an existing one, with a new image used.
# It copies all volumes and attaches them to the new container.

oldcontainer=$1
newcontainer=$2
newport=$3
newimage=$4

# create temp dir
tmpdir=$(mktemp -d -t containercopy-XXXXXXXXXXXX)
cd $tmpdir
echo "Create temp dir $tmpdir"

volume_paths=( $(docker inspect $oldcontainer | jq '.[] | .Mounts[].Name, .Mounts[].Source, .Mounts[].Destination') )

# paths contain both volume names, paths and destinations, so the number of volumes will be the original number divided by threei
volume_count=$(( ${#volume_paths[@]} / 3 ))

echo "Volumes: $volume_count"

volume_mounts=""

for i in $(seq $volume_count); do
    
	volume_name=${volume_paths[i-1]}
	volume_name=$(echo $volume_name | tr -d '"')

    	volume_path=${volume_paths[(i-1)+volume_count]}
    	volume_path=$(echo $volume_path | tr -d '"')
	echo "$volume_name : $volume_path"

	volume_dest=${volume_paths[(i-1)+volume_count * 2]}
    	volume_dest=$(echo $volume_dest | tr -d '"')
	echo "$volume_name : $volume_path : $volume_dest"

	# create new volume name by replacing the name of the container in the old volume's name
    	new_volume="${volume_name/$oldcontainer/"$newcontainer"}"

	# create new volume
	docker volume create $new_volume
    	echo "Created new volume: $new_volume"

	new_volume_path="${volume_path/$oldcontainer/"$newcontainer"}"
	echo "New volume path: $new_volume_path"

	# copy contents of the old volume to the new one
	cp -rf $volume_path/* $new_volume_path/

	# append volume mount to command
	volume_mounts="$volume_mounts -v $new_volume:$volume_dest"

done

echo "Creating container $newcontainer with volumes: $volume_mounts"

# start the new container
docker run -d --name $newcontainer -p $newport:8080 $volume_mounts -t $newimage
