#!/bin/bash
shopt -s extglob

echo -e "WELCOME TO USER REGISTRATION VALIDATION PROBLEM\n\n"

#########REQUIRED VARIABLES##############
namePattern="[[:upper:]][a-zA-Z]{2,}$"
emailPattern="^(abc)([a-zA-Z0-9\_\-\.\+-]*)([a-zA-Z0-9]*)@([a-zA-Z0-9]*)\.([a-zA-Z]*)\.*([a-zA-Z]{2})*"
mobilePattern="^(91)([[:space:]]{1})([0-9]{10})$"

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
    echo "Valid Email Id"
 else
    echo "Invalid Email Id"
    echo "Execution Terminated ... Try again"
    exit 0
 fi
}

function CheckMobile
{
 mobUser="$1"
 if [[ $mobUser =~ $mobilePattern ]];then
    echo "Valid Mobile Number"
 else
    echo "Invalid mobile number"
    echo "Execution Terminated ... Try again"
    exit 0
 fi
}

function CheckPassword
{
  passUser="$1"
  len="${#passUser}"
  count=0

  if [ $len -ge 8 ]; then
       echo "CHECKED: Password length is 8 or more then "
       #checking upper character in password
       passUpper=`echo "$passUser" | grep [A-Z]`
    if [ ! -z "$passUpper" ]; then
       echo "CHECKED: Password have at least one upper case character"
       #checking number in password
       passNum=`echo "$passUser" | grep [0-9]`
       if [ ! -z "$passNum" ];then
          echo "CHECKED: Password have at least one numeric character"

          #checking 1 special character in password
          passSpecial=`echo "$passUser" | grep [,\@\.\!\#\$\%\^\&\*\-]`

          #counting special characters
          passSpecialCount=`echo $passSpecial | sed -e 's/\(.\)/\n/g' | grep [,\@\.\!\#\$\%\^\&\*\-] | wc -l `
          if [ ! -z "$passSpecial" ];then
             echo "$passSpecial" > PassFile.txt
             while IFS= read -r -n1 char
             do
                  check=`echo $char | grep [,\@\.\!\#\$\%\^\&\*\-]`
                  if [ ! -z $check ];then
                     ((count++))
                      check=""
                  fi
             done < "PassFile.txt"
           if [ $count -eq 1 ];then
             echo "Valid Password"
           else
             echo "password have more than one special character"
             echo "Execution Terminated ... Try again"
             exit 0
	   fi
         else
             echo "Password is weak ... Include exact one special character in password"
             echo "Execution Terminated ... Try again"
             exit 0
         fi
       else
         echo "Password is weak ... Include Numbers in password"
         echo "Execution Terminated ... Try again"
       fi
    else
      echo "Password is weak ... Include Upper case character in password"
      echo "Execution Terminated ... Try again"
    fi
  else
    echo "password lenght should be greater than or equal 8 hence weak password"
    echo "Execution Terminated ... Try again"
    exit 0
  fi
}

#Taking Input from user
#read -p "Enter User First Name:" fname
#read -p "Enter User Last Name:" lname
read -p "Enter User Email Id:" emailId
#read -p "Enter User Mobile No:" mobNumber
#read -p "Enter User Password:" passwordString

echo ""

#Checking user first name of User
CheckName $fname
fname=$nameUser

#Checking user lst name of User
CheckName $lname
lname=$nameUser

#Checking user's email id
CheckEmail $emailId

#Checking user's mobile number
CheckMobile "$mobNumber"

#Checking user's password
CheckPassword $passwordString

echo -e "\n\n---------------------------------------------"
echo "USER INFORMATION"
echo "---------------------------------------------"
echo "First Name: $fname"
echo "Last Name: $lname"
echo "Email Id: $emailId"
echo "Mobile Number: $mobNumber"
echo "Password: $passwordString"
echo "---------------------------------------------"

