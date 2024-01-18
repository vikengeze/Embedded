#!/bin/bash

if [[ $@ == '' ]]
then
	echo "Input number of iterations"
	exit
fi

reps=$1
Start=1

echo "Using original phods code"

for (( c=$Start; c<=$reps; c++ ));
do
	cd ..

	gcc -O0 -o phods phods_original.c
	
	./phods >> ./Outputs/1.2/helper.txt

	cd Scripts
done

###################################################################cleanup###################################################################
cd ..
cd Outputs/1.2
cat helper.txt > "1.2.txt"

rm helper.txt

cd ../..
cd Scripts
###############################################################Mean_Calculation##############################################################

MeanCalc="./Mean.py"

/bin/bash -c "python3 $MeanCalc 1.2" 