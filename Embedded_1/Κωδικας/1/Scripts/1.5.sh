#!/bin/bash

if [[ $@ == '' ]]
then
	echo "Input number of iterations"
	exit
fi

reps=$1
Start=1

for Bx in 1  2  3  4  6  8  9  12  16  18  24  36  48  72  144;
do
	for By in 1  2  4  8  11  16  22  44  88  176;
	do
		/bin/bash -c "python3 1.5.py $Bx $By" 
		cd ..
		gcc -O0 -o phods phods_1.5.c
		cd Scripts
		for (( c=$Start; c<=$reps; c++ ));
		do
			cd ..

			#echo "Using optimised phods code"
			
			./phods >> ./Outputs/1.5/helper.txt
			cd Scripts
		done
		cd ..
		cd Outputs/1.5

		name="1.5_${Bx}_${By}.txt"	
		cat helper.txt > "$name"
		rm helper.txt

		cd ../..
		cd Scripts

		/bin/bash -c "python3 ./Mean.py 1.5_${Bx}_${By}"
		echo "Block sizes $Bx $By iterations complete"
	done
done

/bin/bash -c "python3 ./1.5_best_search.py"