import sys

file = open("./drr.h", 'r')

text = ''

for line in file:
	if line.split(' ')[0] == "#define":
		if line.split(' ')[1] == sys.argv[1] + "_CL\n" or line.split(' ')[1] == sys.argv[2] + "_PK\n":
			text = text + line
		else:
			text = text + "//" + line
	elif line.split(' ')[0] == "//#define":
		if line.split(' ')[1] == sys.argv[1] + "_CL\n":
			text = text + "#define " + sys.argv[1] + "_CL\n"
		elif line.split(' ')[1] == sys.argv[2] + "_PK\n":
			text = text + "#define " + sys.argv[2] + "_PK\n"
		else:
			text = text + line

	else:
		text = text + line

file = open("./drr.h", 'w')
file.write(text)