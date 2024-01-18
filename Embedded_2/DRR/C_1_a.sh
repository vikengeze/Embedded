#!/bin/bash

for arg1 in "SLL" "DLL" "DYN_ARR";
do
	for arg2 in "SLL" "DLL" "DYN_ARR";
	do
		/bin/bash -c "python3 combos.py $arg1 $arg2"

		echo "Compiling combination $arg1 $arg2"
		/bin/bash -c "gcc48 drr.c -o drr_'$arg1'_'$arg2' -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations"
	done
done

for arg1 in "SLL" "DLL" "DYN_ARR";
do
	for arg2 in "SLL" "DLL" "DYN_ARR";
	do
		runner='drr_'$arg1'_'$arg2
		mem_acc_out=Outputs/ALL_memory_accesses.txt
		mem_foot_out='Outputs/'$arg1'_'$arg2'_memory_footprint.txt'

		echo "Running combination $arg1 $arg2"

	    valgrind --log-file="mem_accesses_log.txt" --tool=lackey --trace-mem=yes ./$runner

	    echo "$runner" >> Outputs/all_memory_accesses.txt
	    cat mem_accesses_log.txt | grep 'I\|L' | wc -l >> $mem_acc_out
	    
	    valgrind --tool=massif ./"$runner"
	    ms_print massif.out.* > $mem_foot_out
	    
	    rm mem_accesses_log.txt
	    rm massif.out.*
	done
done
