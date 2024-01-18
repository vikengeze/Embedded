import sys

maxi = maxi2 = maxi3 = 0
maxi_numbers = maxi_numbers2 = maxi_numbers3 = [0, 0]
for x in 1, 2, 3, 4, 6, 8, 9, 12, 16, 18, 24, 36, 48, 72, 144:
	for y in 1, 2, 4, 8, 11, 16, 22, 44, 88, 176:
		x= str(x)
		y= str(y)
		file = open("../Outputs/1.5/1.5_" + x + '_' + y + "_mean.txt", 'r')
		for line in file:
			if line.split(':')[0] == 'Mean':
				Check = line.split(':')[1]
				Check = Check.split(' ')[1]
				Check = Check.split('\n')[0]
				Check = float(Check)
				if (Check > maxi):
					maxi3 = maxi2
					maxi2 = maxi
					maxi = Check
					maxi_numbers3 = maxi_numbers2
					maxi_numbers2 = maxi_numbers
					maxi_numbers = [x, y]
				elif (Check > maxi2):
					maxi3 = maxi2
					maxi2 = Check
					maxi_numbers3 = maxi_numbers2
					maxi_numbers2 = [x, y]
				elif (Check > maxi3):
					maxi3 = Check
					maxi_numbers3 = [x, y]

print("Worst iteration is for Bx=" + str(maxi_numbers[0]) + " and By=" + str(maxi_numbers[1]) + ". Mean time achieved is " + str(maxi) + " seconds")
print("Runners up are configurations: ")
print("Bx=" + str(maxi_numbers2[0]) + ", By=" + str(maxi_numbers2[1]) + ", with a mean time of " + str(maxi2) + " seconds")
print("Bx=" + str(maxi_numbers3[0]) + ", By=" + str(maxi_numbers3[1]) + ", with a mean time of " + str(maxi3) + " seconds")