import sys

f = open('portList', 'r')
host = ""
for line in f.readlines():	
	#print line
	words = line.split()
	if len(words) > 1:
		if words[0] == "Nmap":
			host = words[4]

		if words[1] == "open":
			print host + " " + words[0].replace("/tcp","")
