#Step3
#Use nmap to grab the current version of specified port and ip address

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