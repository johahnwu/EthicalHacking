# Host discovery 

read -p "What range of addresses do you want to scan? " range
echo "Step 1 scanning" $range
nmap -sn $range > nmapOutput
python python_script.py > liveHosts

# Port Scan
# Port 21-FTP, 22-SSH, Port 25-SMTP, Port 1433-MS SQL Server
echo "Step 2 scanning ports on live hosts"
nmap -n --open -p21,22,25,1433 -iL liveHosts > portList
python PortParser.py > parsedPorts



#Banner Grabbing
echo "Step 3 grabbing versions of used products"
output='portSoftware'

if [ -f $output ]; then
rm $output
fi

filename='parsedPorts'
xmlfilename='cpeResult'

if [ -f $xmlfilename ]; then
rm $xmlfilename
fi

while read p;
do
        line=($p)
        ip=${line[0]}
        port=${line[1]}
        resultfile=$ip':'$port
        nmap -sV $ip -p$port -oX $resultfile >> $output
        python parseXML.py $resultfile >> $xmlfilename
done < $filename

# Vunerability checking
echo "Step 4 checking database for vulnerabilities"

filename='cpeResult'
output='potentialAttacks'

if [[ -f $output ]]; then
	#statements
	rm $output
fi

#python vFeed/vfeedcli.py -u
while IFS='' read -r line || [[ -n "$line" ]]; do
	#statements
        if [[ $line != "No Exploitable" ]]; then
	       python vFeed/vfeedcli.py -s $line >> $output
        fi
done < $filename

rm 10*
