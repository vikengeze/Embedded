#!/bin/bash
#!/bin/sh

Scripts_Dir=Scripts
Output_Dir=Outputs

if [[ $@ == '' ]]
then
	echo "Input desired script"
	exit
fi

ScriptOutDir=${Output_Dir}/$1
mkdir -p $ScriptOutDir

cd "$Scripts_Dir"

runner="./${1}.sh $2"

if [[ $@ != "1.6" ]]
then
	echo "Outputs from Script $1 are in Outputs/$1/$1.txt"
else
	echo "Boxplots are saved on Outputs/1.6"
fi

/bin/bash -c "$runner" 

cd ..