import pandas as pd
import random
import matplotlib.pyplot as plt
import sys

n = 157

Type = [0 for i in range(3*n)]
Seconds = [0 for i in range(3*n)]

counter = 0

################################ 1.2 ################################
file = open("../Outputs/1.2/1.2_mean.txt", 'r')
for line in file:
	if line[1] == 'i':
		Type[counter] = "Minimum"
		Seconds[counter] = float(line.split(' ')[1])
		counter = counter + 1

	if line[1] == 'a':
		Type[counter] = "Maximum"
		Seconds[counter] = float(line.split(' ')[1])
		counter = counter + 1

	if line[1] == 'e':
		Type[counter] = "Mean"
		Seconds[counter] = float(line.split(' ')[1])
		counter = counter + 1
#####################################################################

################################ 1.3 ################################
file = open("../Outputs/1.3/1.3_mean.txt", 'r')
for line in file:
	if line[1] == 'i':
		Type[counter] = "Minimum"
		Seconds[counter] = float(line.split(' ')[1])
		counter = counter + 1

	if line[1] == 'a':
		Type[counter] = "Maximum"
		Seconds[counter] = float(line.split(' ')[1])
		counter = counter + 1

	if line[1] == 'e':
		Type[counter] = "Mean"
		Seconds[counter] = float(line.split(' ')[1])
		counter = counter + 1
#####################################################################

################################ 1.4 ################################
for x in 1, 2, 4, 8, 16:
	x = str(x)
	file = open("../Outputs/1.4/1.4_" + x + "_mean.txt", 'r')
	for line in file:
		if line[1] == 'i':
			Type[counter] = "Minimum"
			Seconds[counter] = float(line.split(' ')[1])
			counter = counter + 1

		if line[1] == 'a':
			Type[counter] = "Maximum"
			Seconds[counter] = float(line.split(' ')[1])
			counter = counter + 1

		if line[1] == 'e':
			Type[counter] = "Mean"
			Seconds[counter] = float(line.split(' ')[1])
			counter = counter + 1
#####################################################################

################################ 1.5 ################################
for x in 1, 2, 3, 4, 6, 8, 9, 12, 16, 18, 24, 36, 48, 72, 144:
	for y in 1, 2, 4, 8, 11, 16, 22, 44, 88, 176:
		x = str(x)
		y = str(y)
		file = open("../Outputs/1.5/1.5_" + x + '_' + y + "_mean.txt", 'r')
		for line in file:
			if line[1] == 'i':
				Type[counter] = "Minimum"
				Seconds[counter] = float(line.split(' ')[1])
				counter = counter + 1

			if line[1] == 'a':
				Type[counter] = "Maximum"
				Seconds[counter] = float(line.split(' ')[1])
				counter = counter + 1

			if line[1] == 'e':
				Type[counter] = "Mean"
				Seconds[counter] = float(line.split(' ')[1])
				counter = counter + 1
#####################################################################

df = pd.DataFrame({"Type": [Type[i] for i in range(3*n)], "Seconds": [Seconds[i] for i in range(3*n)]})
grouped = df.groupby(["Type"])

df2 = pd.DataFrame({col:vals['Seconds'] for col,vals in grouped})

meds = df2.median()
meds.sort_values(ascending=True, inplace=True)
df2 = df2[meds.index]
df2.boxplot()

plt.ylabel("Seconds")
plt.suptitle("Boxplot of Minimum, Mean and Maximum Values")
#plt.show()

plt.savefig("../Outputs//1.6/Boxplot_per_Type.png", dpi=400)