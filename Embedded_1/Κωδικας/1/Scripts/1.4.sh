#!/bin/bash

if [[ $@ == '' ]]
then
	echo "Input number of iterations"
	exit
fi

reps=$1
Start=1

for B in 1 2 4 8 16;
do
	/bin/bash -c "python3 1.4.py $B" 
	cd ..
	gcc -O0 -o phods phods.c
	cd Scripts
	for (( c=$Start; c<=$reps; c++ ));
	do
		cd ..

		#echo "Using optimised phods code"
		
		./phods >> ./Outputs/1.4/helper.txt
		cd Scripts
	done
	cd ..
	cd Outputs/1.4

	cat helper.txt > "1.4_${B}.txt"
	rm helper.txt

	cd ../..
	cd Scripts

	/bin/bash -c "python3 ./Mean.py 1.4_$B"
	echo "Block size $B iterations complete"
done