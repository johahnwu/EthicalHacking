import xml.etree.ElementTree
import sys

e = xml.etree.ElementTree.parse(sys.argv[1]).getroot()
cpe = False
for tag in e.iter('cpe'):
	cpe = True
	print(tag.text)
if(not cpe):
	print("No Exploitable")

