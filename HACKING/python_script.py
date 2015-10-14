import sys

f = open('nmapOutput', 'r')
for line in f.readlines():
	#check if line is blank (new host)
	words = line.split()
	if  len(words) > 3 and words[0] == "Nmap" and words[1] == "scan" and words[2] == "report":
		if len(words) == 5:
			print words[4]
		else:
			print words[5].replace("(", "").replace(")", "")
