#!/bin/bash
shopt -s extglob

echo "WELCOME TO USER REGISTRATION VALIDATION PROBLEM"


namePattern="[[:upper:]][a-zA-Z]{2,}$"
flag=0

read -p "Enter User First Name:" fname

function CheckNameFirstLetter
{
  if [[ $fname =~ $namePattern ]];then
      flag=1
   else
      flag=0
  fi
}

#Checking user first name of User
CheckNameFirstLetter
if [[ $flag -eq 1 ]];then
   echo -e "\nValid $fname"
else
   echo -e "\nInvalid $fname"
   echo "First character must be capital and lenght must be more than 2 characters."
   echo "Convert first letter to uppercase ... Checking again"
   fname=`echo $fname | sed -e "s/\b\(.\)/\u\1/g"`
   CheckNameFirstLetter
   if [[ $flag -eq 1 ]];then
       echo -e "\nValid $fname"
   else
       echo -e "\nInvalid $fname"
       echo "First character must be capital and lenght must be more than 2 characters."
       echo "Converion failed"
       echo "Execution terminating ... Try again ..."
   fi
fi

echo -e "\n\n---------------------------------------------"
echo "USER INFORMATION"
echo "---------------------------------------------"
echo "First Name: $fname"
echo "---------------------------------------------"
