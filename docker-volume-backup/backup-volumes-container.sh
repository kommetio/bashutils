#! /bin/bash

container=$1
dirname="backup-$container-$(date +"%FT%H%M%z")"

echo "Creating folder $dirname"

mkdir $dirname
cd $dirname

volume_paths=( $(docker inspect $container | jq '.[] | .Mounts[].Name, .Mounts[].Source') )

# paths contain both volume names and paths, so the number of volumes will be the original number divided by two
volume_count=$(( ${#volume_paths[@]} / 2 ))

echo "Volumes: $volume_count"

for i in $(seq $volume_count); do
    
    volume_name=${volume_paths[i-1]}
    volume_name=$(echo $volume_name | tr -d '"')

    volume_path=${volume_paths[(i-1)+volume_count]}
    volume_path=$(echo $volume_path | tr -d '"')
    echo "$volume_name : $volume_path"

    # create an archive with volume name
    tar -zcvf "$volume_name.tar" $volume_path

done


