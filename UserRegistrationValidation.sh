#!/bin/bash
shopt -s extglob

echo -e "WELCOME TO USER REGISTRATION VALIDATION PROBLEM\n\n"

#########REQUIRED VARIABLES##############
namePattern="[[:upper:]][a-zA-Z]{2,}$"
flag=0


###########FUNCTIONS################
function CheckNameFirstLetter
{
  nameUser=$1
  if [[ $nameUser =~ $namePattern ]];then
      flag=1
   else
      flag=0
  fi
}

function CheckName
{
 nameUser=$1
 
 #Checking user first name of User
 CheckNameFirstLetter $nameUser
 if [[ $flag -eq 1 ]];then
   echo -e "\nValid $nameUser"
 else
   echo -e "\nInvalid $nameUser"
   echo "First character must be capital and lenght must be more than 2 characters."
   echo "Convert first letter to uppercase ... Checking again"
   nameUser=`echo $nameUser | sed -e "s/\b\(.\)/\u\1/g"`
   CheckNameFirstLetter $nameUser
   if [[ $flag -eq 1 ]];then
       echo -e "\nValid $nameUser"
   else
       echo -e "\nInvalid $nameUser"
       echo "First character must be capital and lenght must be more than 2 characters."
       echo "Converion failed"
       echo "Execution terminating ... Try again ..."
   fi
 fi

}

#Taking Input from user
read -p "Enter User First Name: " fname
read -p "Enter User Last Name: " lname

#Checking user first name of User
CheckName $fname
fname=$nameUser

#Checking user lst name of User
CheckName $lname
lname=$nameUser


echo -e "\n\n---------------------------------------------"
echo "USER INFORMATION"
echo "---------------------------------------------"
echo "First Name: $fname"
echo "Lst Name: $lname"
echo "---------------------------------------------"
