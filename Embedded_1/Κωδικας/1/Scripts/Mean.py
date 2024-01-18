import sys

if sys.argv[1][2] == '4':
	file = open("../Outputs/1.4/" + sys.argv[1] + ".txt", 'r')
elif sys.argv[1][2] == '5':
	file = open("../Outputs/1.5/" + sys.argv[1] + ".txt", 'r')
else:
	file = open("../Outputs/" + sys.argv[1] + '/' + sys.argv[1] + ".txt", 'r')

total = 0
mini = -1
maxi = 0

flag = ''
totaln=0
for line in file:
	if line[0] != 'E':
		continue
	totaln = totaln+1
	number = int(line.split(' ')[2])
	total = total + number
	if(number > maxi):
		maxi = number
	if(number < mini or mini < 0):
		mini = number

if totaln == 0:
	print(sys.argv[1])
else:
	mean = total/totaln

file.close()

if sys.argv[1][2] == '4':
	file = open("../Outputs/1.4/" + sys.argv[1] + "_mean.txt", 'w')
elif sys.argv[1][2] == '5':
	file = open("../Outputs/1.5/" + sys.argv[1] + "_mean.txt", 'w')
else:
	file = open("../Outputs/" + sys.argv[1] + '/' + sys.argv[1] + "_mean.txt", 'w')

file.write("Minimum: " + str(mini) + "\n")
file.write("Maximum: " + str(maxi) + "\n")
file.write("Mean: " + str(mean) + "\n")
