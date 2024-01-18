
original = open("./Outputs/dijkstra_original.txt")
sll = open("./Outputs/dijkstra_sll.txt")
dll = open("./Outputs/dijkstra_dll.txt")
dyn_arr = open("./Outputs/dijkstra_dyn_arr.txt")

original_text = original.read()
sll_text = sll.read()
dll_text = dll.read()
dyn_arr_text = dyn_arr.read()

flag = 1

if sll_text != original_text:
	print("Error in sll variation")
	flag = 0
if dll_text != original_text:
	print("Error in dll variation")
	flag = 0
if dyn_arr_text != original_text:
	print("Error in dynamic array variation")
	flag = 0

if flag == 1:
	print("Outputs are all the same, executions successful\n")
