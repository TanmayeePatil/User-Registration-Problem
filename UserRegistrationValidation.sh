#!/bin/bash
shopt -s extglob

echo -e "WELCOME TO USER REGISTRATION VALIDATION PROBLEM\n\n"

#########REQUIRED VARIABLES##############
namePattern="[[:upper:]][a-zA-Z]{2,}$"
emailPattern="^(abc)([a-zA-Z0-9\_\-\.\+]*)@(bl)\.(co)\.*([a-zA-Z]{2})*"

###########FUNCTIONS################
function CheckNameFirstLetter
{
  nameUser=$1
  flag=0

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
   echo "Valid Name: $nameUser"
 else
   echo "Invalid $nameUser"
   echo "First character must be capital and lenght must be more than 2 characters."
   echo "Convert first letter to uppercase ... Checking again"
   nameUser=`echo $nameUser | sed -e "s/\b\(.\)/\u\1/g"`
   CheckNameFirstLetter $nameUser
   if [[ $flag -ne 1 ]];then
       echo "Invalid $nameUser"
       echo "First character must be capital and lenght must be more than 2 characters."
       echo "Converion failed"
       echo "Execution terminating ... Try again ..."
   fi
 fi

}

function CheckEmail
{
 emailUser=$1

 if [[ $emailUser =~ $emailPattern ]];then
    echo "Valid Email Id."
 else
    echo "Invalid Email Id"
    echo "Execution Terminated ... Try again"
    exit 0
 fi
}


#Taking Input from user
read -p "Enter User First Name: " fname
read -p "Enter User Last Name: " lname
read -p "Enter User Email Id:" emailId

#Checking user first name of User
CheckName $fname
fname=$nameUser

#Checking user lst name of User
CheckName $lname
lname=$nameUser

#Checking user's email id
CheckEmail $emailId

echo -e "\n\n---------------------------------------------"
echo "USER INFORMATION"
echo "---------------------------------------------"
echo "First Name: $fname"
echo "Last Name: $lname"
echo "Email Id: $emailId"
echo "---------------------------------------------"
