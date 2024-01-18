import sys

file = open("../phods.c", 'r')

text = ''

for line in file:
	if line.split(' ')[0] == "#define":
		if line.split(' ')[1] == 'B':
			kapa = [0 for x in range(0, 10)]
			x=0
			for x in range(0,10):
				kapa[x] = line.split(' ')[x]
				if x == 2:
					kapa[x] = sys.argv[1]
				#print(kapa)
				if x == 0:
					text = text + kapa[x]
				else:
					text = text + ' ' + kapa[x]
		else:
			text = text + line
	else:
		text = text + line

file = open("../phods.c", 'w')
file.write(text)