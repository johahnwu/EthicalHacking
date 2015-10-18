#Step3
#Use nmap to grab the current version of specified port and ip address

output='Step3Result.txt'

if [ -f $output ]; then
rm $output
fi

filename='PortScan.txt'
xmlfilename='cpeResult.txt'

if [ -f $xmlfilename ]; then
rm $xmlfilename
fi

while read p;
do
        line=($p)
        ip=${line[0]}
        port=${line[1]}
        resultfile=$ip':'$port
        nmap -sV $ip -p$port -oX $resultfile
        python parseXML.py $resultfile >> $xmlfilename
        nmap -sV $ip -p$port >> $output
done < $filename
sed -i '/Starting Nmap/d' ./Step3Result.txt
sed -i '/Host is up/d' ./Step3Result.txt
sed -i '/MAC Address/d' ./Step3Result.txt
sed -i '/Service detection/d' ./Step3Result.txt
sed -i '/Nmap done:/d' ./Step3Result.txt
sed -i '/Service Info:/d' ./Step3Result.txt
sed -i '/Note: /d' ./Step3Result.txt
sed -i '/^\s*$/d' ./Step3Result.txt