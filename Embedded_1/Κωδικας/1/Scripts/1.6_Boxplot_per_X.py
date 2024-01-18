import pandas as pd
import random
import matplotlib.pyplot as plt
import sys

X = [0 for i in range(3*150)]
Y = [0 for i in range(3*150)]
Type = [0 for i in range(3*150)]
Seconds = [0 for i in range(3*150)]

counter = 0

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
				X[counter] = int(x)
				Y[counter] = int(y)
				counter = counter + 1

			if line[1] == 'a':
				Type[counter] = "Maximum"
				Seconds[counter] = float(line.split(' ')[1])
				X[counter] = int(x)
				Y[counter] = int(y)
				counter = counter + 1

			if line[1] == 'e':
				Type[counter] = "Mean"
				Seconds[counter] = float(line.split(' ')[1])
				X[counter] = int(x)
				Y[counter] = int(y)
				counter = counter + 1
#####################################################################

df = pd.DataFrame({"Type": [Type[i] for i in range(3*150)], "Seconds": [Seconds[i] for i in range(3*150)], "X": [X[i] for i in range(3*150)], "Y": [Y[i] for i in range(3*150)]})
grouped = df.groupby(["X"])

df2 = pd.DataFrame({col:vals['Seconds'] for col,vals in grouped})

meds = df2.median()
#meds.sort_values(ascending=True, inplace=True)
df2 = df2[meds.index]
df2.boxplot()

plt.ylabel("Seconds")
plt.xlabel("Value of Bx")
plt.suptitle("Boxplot of all By values per Bx")
#plt.show()

plt.savefig("../Outputs/1.6/Boxplot_per_X.png", dpi=400)