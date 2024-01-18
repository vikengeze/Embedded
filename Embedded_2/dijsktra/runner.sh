#!/bin/bash

echo "Compiling original dijkstra code"
/bin/bash -c 'gcc48 -Wall -Wextra -g -Wno-unused-but-set-variable -o dijkstra_original dijkstra_original.c  -pthread'

echo "Compiling dijkstra code using Single Linked List"
/bin/bash -c 'gcc48 -DSLL -Wall -Wextra -g -Wno-unused-but-set-variable -o dijkstra_sll dijkstra.c  -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations'

echo "Compiling dijkstra code using Double Linked List"
/bin/bash -c 'gcc48 -DDLL -Wall -Wextra -g -Wno-unused-but-set-variable -o dijkstra_dll dijkstra.c  -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations'

echo "Compiling dijkstra code using Dynamic Array
"
/bin/bash -c 'gcc48 -DDYN_ARR -Wall -Wextra -g -Wno-unused-but-set-variable -o dijkstra_dyn_arr dijkstra.c  -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations'

echo "Compilations successful
"

echo "Executing all variations and checking to see if outputs are all correct:"
/bin/bash -c './dijkstra_original input.dat > Outputs/dijkstra_original.txt'
/bin/bash -c './dijkstra_sll input.dat > Outputs/dijkstra_sll.txt'
/bin/bash -c './dijkstra_dll input.dat > Outputs/dijkstra_dll.txt'
/bin/bash -c './dijkstra_dyn_arr input.dat > Outputs/dijkstra_dyn_arr.txt'
/bin/bash -c 'python3 check.py'

echo "Creating memory acceses and memory footprint files..
"

mem_acc_out=Outputs/all_memory_accesses.txt

for kapa in "original" "sll" "dll" "dyn_arr";
do
	echo "Executing $kapa variation.."
	if [ $kapa == "original" ]; then
		runner='./dijkstra_original input.dat'
	elif [[ $kapa == "sll" ]]; then
		runner='./dijkstra_sll input.dat'
	elif [[ $kapa == "dll" ]]; then
		runner='./dijkstra_dll input.dat'
	elif [[ $kapa == "dyn_arr" ]]; then
		runner='./dijkstra_dyn_arr input.dat'
	fi

	mem_foot_out='Outputs/'$kapa'_memory_footprint.txt'

	valgrind --log-file="mem_accesses_log.txt" --tool=lackey --trace-mem=yes $runner

	echo $kapa >> $mem_acc_out
	cat mem_accesses_log.txt | grep 'I\|L' | wc -l >> $mem_acc_out
		    
	valgrind --tool=massif $runner
	ms_print massif.out.* > $mem_foot_out
		    
	rm mem_accesses_log.txt
	rm massif.out.*

	echo "Done, output in dijkstra_$kapa.txt
	"
done


