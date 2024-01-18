import matplotlib.pyplot as plot


mem_accesses = [0 for x in range(0, 9)]
mem_acc_combo = ['nada' for x in range(0, 9)]

mem_footprint = [0 for x in range(0, 9)]
mem_foot_combo = ['nada' for x in range(0, 9)]

i=0
j=0

for x in "SLL", "DLL", "DYN_ARR":
	for y in "SLL", "DLL", "DYN_ARR":
		mem_acc_file = open("./Outputs/all_memory_accesses.txt", 'r')
		mem_foot_file = open("./Outputs/" + x + "_" + y + "_memory_footprint.txt" )
		for line in mem_acc_file:
			if line[1] == 'r':
				line2 = line.split('_')[2]
				if line2 == "ARR" and x.split('_')[0] == "DYN":
					line3 = line.split('_')[3]
					if line3.split('\n')[0] == y.split('_')[0]:
						var = int(mem_acc_file.readline().split('\n')[0])
						var = int(var)
						mem_accesses[i] = var
						mem_acc_combo[i] = x + "_" + y
						i = i + 1
				elif line.split('_')[1] == x.split('_')[0] and line2.split('\n')[0] == y.split('_')[0]:
					var = int(mem_acc_file.readline().split('\n')[0])
					var = int(var)
					mem_accesses[i] = var
					mem_acc_combo[i] = x + "_" + y
					i = i + 1
		k = 0
		for line in mem_foot_file:
			if k == 7:
				if line.split(' ')[4] == "MB\n":
					mul = 1000
				else:
					mul = 1
			if k == 8:
				mem_footprint[j] = float(line.split('^')[0])*mul
				mem_foot_combo[j] = x + "_" + y
				j=j+1
			k = k + 1

for x in range(0,9):
	if mem_foot_combo[x] != mem_acc_combo[x]:
		print("Error on combo selections")
		exit()
	label = mem_foot_combo[x]
	plot.plot(mem_footprint[x], mem_accesses[x], 'bo')
	if "_DYN_ARR" not in label:
		if label == "SLL_DLL":
			plot.annotate(label, (mem_footprint[x], mem_accesses[x]), textcoords = 'offset points', xytext = (-30,15))
		else:
			plot.annotate(label, (mem_footprint[x], mem_accesses[x]), textcoords = 'offset points', xytext = (-30,-15))
	else:
		if "SLL" in label:
			plot.annotate(label, (mem_footprint[x], mem_accesses[x]), textcoords = 'offset points', xytext = (-30,-15))
		else:
			plot.annotate(label, (mem_footprint[x], mem_accesses[x]), textcoords = 'offset points', xytext = (-30,10))


plot.plot(mem_footprint, mem_accesses, 'ro')

plot.xlabel('Memory footprint in KB')
plot.ylabel('Memory accesses')
plot.title('DRR data comparison plot')

plot.show()
#plot.savefig("1_a.png", dpi=600)
