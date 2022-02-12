#!/bin/bash
ran_num=$((RANDOM%100 + 1))
if [ "$ran_num" -eq 100 ]
then
	let "ran_num -= 1"
fi

is_guessed=0
count=0

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
	elif [ "$guess_num" -lt "$ran_num" ]
	then
		echo "The guessing number is bigger than "$guess_num""
		let "count += 1"
		let "guesses = 3 - count"
		echo "You've got $guesses tries"
	else
		echo "The guessing number is less than "$guess_num""
		let "count += 1"
		let "guesses = 3 - count"
		echo "You've got "$guesses" tries"
	fi
done

if [ $is_guessed -eq 0 ]
then
	echo "You are out of guesses! You lost! The random number was $ran_num"
fi

