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





# Vunerability checking
