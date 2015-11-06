#! /bin/bash


filename='cpeResult.txt'
output='potentialAttacks.txt'

if [[ -f $output ]]; then
	#statements
	rm $output
fi

#python vFeed/vfeedcli.py -u
while IFS='' read -r line || [[ -n "$line" ]]; do
	#statements
	python vFeed/vfeedcli.py -s $line >> $output
done < $filename
