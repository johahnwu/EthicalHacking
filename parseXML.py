import xml.etree.ElementTree
import sys

e = xml.etree.ElementTree.parse(sys.argv[1]).getroot()
cpe = False
for tag in e.iter('cpe'):
	cpe = True
	if((tag.text).startswith("cpe:/a:",0,7)):
		print(tag.text)
	else:
		print("No Exploitable")
if(not cpe):
	print("No Exploitable")

