import sys

mini = mini2 = mini3 = -1
mini_numbers = mini_numbers2 = mini_numbers3 = [0, 0]
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
				if (Check < mini or mini < 0):
					mini3 = mini2
					mini2 = mini
					mini = Check
					mini_numbers3 = mini_numbers2
					mini_numbers2 = mini_numbers
					mini_numbers = [x, y]
				elif (Check < mini2 or mini2 < 0):
					mini3 = mini2
					mini2 = Check
					mini_numbers3 = mini_numbers2
					mini_numbers2 = [x, y]
				elif (Check < mini3 or mini3 < 0):
					mini3 = Check
					mini_numbers3 = [x, y]

print("Best iteration is for Bx=" + str(mini_numbers[0]) + " and By=" + str(mini_numbers[1]) + ". Mean time achieved is " + str(mini) + " seconds")
print("Runners up are configurations: ")
print("Bx=" + str(mini_numbers2[0]) + ", By=" + str(mini_numbers2[1]) + ", with a mean time of " + str(mini2) + " seconds")
print("Bx=" + str(mini_numbers3[0]) + ", By=" + str(mini_numbers3[1]) + ", with a mean time of " + str(mini3) + " seconds")