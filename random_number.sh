#!/bin/bash
ran_num=$RANDOM
let "ran_num %= 100"

while [ "$ran_num" -eq 0 ]
do
	ran_num=$RANDOM
	let "ran_num %= 100"
done

is_guessed=0
count=0

zero=0
three=3

while [ "$is_guessed" -eq  0 ] && [ "$count" -lt 3 ]
do
	echo "Enter the guessing number:"
	read guess_num 
	if [ "$guess_num" -eq "$ran_num" ] 
	then
		echo "Congrats! You guessed the number!"
		let "is_guessed += 1"
		let "count += 1"
		echo "You guessed in $count tries"
	else
		echo "Wrong!"
		let "count += 1"
		let "guesses = 3 - count"
		echo "You've got $guesses tries"
	fi
done

if [ $is_guessed -eq 0 ]
then
	echo "You are out of guesses! You lost! The random number was $ran_num"
fi

