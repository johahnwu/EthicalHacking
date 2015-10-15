# Host discovery 

read -p "What range of addresses do you want to scan? " range
echo Scanning $range
nmap $range > nmapOutput
python python_script.py > liveHosts

# Port Scan
# Port 21-FTP, Port 25-SMTP, Port 1433-MS SQL Server
nmap -n --open -p21,25,1433 -iL liveHosts -oN portList
python PortParser.py > parsedPorts



#Banner Grabbing
output='Step3Result.txt'

if [ -f $output ]; then
rm $output
fi

filename='parsedPorts'
while read p;
do
        line=($p)
        ip=${line[0]}
        port=${line[1]}
        nmap -sV $ip -p$port >> $output
done < $filename
sed -i '/Starting Nmap/d' ./$output
sed -i '/Host is up/d' ./$output
sed -i '/MAC Address/d' ./$output
sed -i '/Service detection/d' ./$output
sed -i '/Nmap done:/d' ./$output
sed -i '/Service Info:/d' ./$output
sed -i '/Note: /d' ./$output
sed -i '/^\s*$/d' ./$output




# Vunerability checking
