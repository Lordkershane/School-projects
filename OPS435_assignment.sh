#!/bin/bash 
# Section: OPSSAA
#Assignmnet #1
#Professor: Azzard
#Due date: October 25th 2015
#Date submitted: October 24th 2015
#AUTHOR: MICHAEL THOMAS
#STUDENT ID: 053912143
#DATE: OCTOBER 18TH 2015
#PURPOSE: OUTPUT USER WESTERN AND CHINESE ZODIAC SIGN AND DAY OF THE WEEK THEY WERE BORN
# SITES USED: http://codereview.stackexchange.com/questions/31652/simple-zodiac-sign-program


 
#################################################################################
# PRINT USAGE IF NO PARAMETERS ARE ENTERED

year=$1 month=$2 day=$3

if [ $# -eq "0" ] 
	then
          echo "You must type your birth date in the one of the formats below
                    formar 1: yyyy mm dd
		    format 2: yyyymmdd
		    format 3: -y yyyy -m mm -d dd"

exit 9
fi
######################################################################################
#		ASSIGN VALUES TO VARIBLES FROM ENTERED PARAMETERS AT THE TERMINAL

	

if [ $# -eq "1" ]
	then
     year=$(echo $1 | cut -c-4)
     month=$(echo $1 | cut -c5-6)
     day=$(echo $1 | cut -c7-8)
fi

if [ $# -eq "6" ]
	then
	 for date in "$@"
     	 do
	  case $date in
	   -y) shift; year="$1";shift;;
	   -m) shift; month="$1";shift;;
	   -d) shift; day="$1";shift;;
  esac
 done
fi



######################################################################################
#		WESTERN ZODIAC CODE 

if [ "$month" -eq "12" ] && [ "$day" -ge "22" ]
	then
	 printf "Your sign is Capricorn" | figlet                               
                          

elif [ "$month" -eq "12" ] && [ "$day" -le "21" ]
	 then
	printf "Your sign is Sagittarius" | figlet

#######################################################################################
		# SAGITTARIUS OR CAPRICORN


elif [ "$month" -eq "11" ] && [ "$day" -ge "23" ]
	then
	 printf "Your sign is Sagittarius" | figlet

elif [ "$month" -eq "11" ] && [ "$day" -le "22" ]
	then
	 printf "Your sign is Scorpio" | figlet

#######################################################
		#  SCORPIO OR LIBRA


elif [ "$month" -eq "10" ] && [ "$day" -ge "23" ]
	then
	 printf "your sign is Scorpio" | figlet

elif [ "$month" -eq "10" ] && [ "$day" -le "22" ]
	then 
	 printf "Your sign is Libra" | figlet

#######################################################
		# LIBRA OR VIRGO


elif [ "$month" -eq "09" ] && [ "$day" -ge "22" ]
        then
         printf "your sign is Libra" | figlet

elif [ "$month" -eq "09" ] && [ "$day" -le "22" ]
        then
         printf "Your sign is Virgo" | figlet

#######################################################
		# VIRGO OR LEO

elif [ "$month" -eq "08" ] && [ "$day" -ge "23" ]
        then
         printf "your sign is Virgo" | figlet

elif [ "$month" -eq "08" ] && [ "$day" -le "22" ]
        then
         printf "Your sign is Leo" | figlet

#######################################################
		# VIRGO OR CANCER

elif [ "$month" -eq "07" ] && [ "$day" -ge "23" ]
        then
         printf "your sign is Leo" | figlet

elif [ "$month" -eq "07" ] && [ "$day" -le "22" ]
        then
         printf "Your sign is Cancer" | figlet

#########################################################
		# CANCER OR GEMINI

elif [ "$month" -eq "06" ] && [ "$day" -ge "22" ]
        then
         printf "your sign is Cancer" | figlet

elif [ "$month" -eq "06" ] && [ "$day" -le "21" ]
        then
         printf "Your sign is Gemini" | figlet

##########################################################
		# GEMINI OR  Taurus


elif [ "$month" -eq "05" ] && [ "$day" -ge "22" ]
        then
         printf "your sign is Gemini" | figlet

elif [ "$month" -eq "05" ] && [ "$day" -le "21" ]
        then
         printf "Your sign is Taurus" | figlet

##########################################################
		# TAURUS OR ARIES


elif [ "$month" -eq "04" ] && [ "$day" -ge "21" ]
        then
         printf "your sign is Taurus" | figlet

elif [ "$month" -eq "04" ] && [ "$day" -le "20" ]
        then
         printf "Your sign is Aries" | figlet


###########################################################
		# ARIES OR PICES


elif [ "$month" -eq "03" ] && [ "$day" -ge "21" ]
        then
         printf "your sign is Aries" | figlet

elif [ "$month" -eq "03" ] && [ "$day" -le "20" ]
        then
         printf "Your sign is Pices" | figlet

###########################################################
		# PICES OR AQUARIUS

elif [ "$month" -eq "02" ] && [ "$day" -ge "20" ]
        then
         printf "your sign is Pices" | figlet

elif [ "$month" -eq "02" ] && [ "$day" -le "19" ]
        then
         printf "Your sign is Aquarius" | figlet
###########################################################
		# AQUARIUS OR CAPRICORN


elif [ "$month" -eq "01" ] && [ "$day" -ge "21" ]
        then
         printf "your sign is Aqarius" | figlet

elif [ "$month" -eq "01" ] && [ "$day" -le "20" ]
        then
         printf "Your sign is Capricorn" | figlet
fi
# 		 END OF WESTERN ZODIAC SIGNS 
#############################################################






#		CHINESE ZODIAC SIGNS
##############################################################



calculation=$((($year/12)*12))
chinese_zodiac_sign=$(($year-calculation))

if [ $chinese_zodiac_sign -eq "0" ]
	then
	 symbol=Monkey

elif [ $chinese_zodiac_sign -eq "1" ]
	then
	symbol="Rooster"

elif [ $chinese_zodiac_sign -eq "2" ]
	then
	 symbol="Dog"

elif [ $chinese_zodiac_sign -eq "3" ]
	then
	symbol="Pig"

elif [ $chinese_zodiac_sign -eq "4" ]
	then
	symbol="Rat"

elif [ $chinese_zodiac_sign -eq "5" ]
	then
	symbol="Ox"

elif [ $chinese_zodiac_sign -eq "6" ]
	then
	symbol="Tiger"

elif [ $chinese_zodiac_sign -eq "7" ]
	then
	symbol="Rabbit"

elif [ $chinese_zodiac_sign -eq "8" ]
	then
	symbol="Dragon"

elif [ $chinese_zodiac_sign -eq "9" ]
	then
	symbol="Snake"

elif [ $chinese_zodiac_sign -eq "10" ]
	then
	symbol="Horse"

elif [ $chinese_zodiac_sign -eq "11" ]
	then
	 symbol="Goat"
fi

#		END OF CHINESE ZODIAC CODE
#################################################################



#		CHINESE ELEMENTS
################################################################

ying_yang=$((year%2))

if [ $ying_yang -eq "0" ]
	then
	element="yang"
elif [ $ying_yang -eq "1" ]
	then
	 element="ying"
fi

elemental=$(echo $year | cut -c4)

if [ $elemental -eq "0" ] || [ $elemental -eq "1" ]
	then
	elemental_type="Metal"

elif [ $elemental -eq "2" ] || [ $elemental -eq "3" ]
	then
	elemental_type="Water"

elif [ $elemental -eq "4" ] || [ $elemental -eq "5" ]
	then
	 elemental_type="Wood"

elif [ $elemental -eq "6" ] || [ $elemental -eq "7" ]
	then
	 elemental_type="Fire"

elif [ $elemental -eq "8" ] || [ $elemental -eq "9" ]
	then
	 elemental_type="Earth"
fi


# 		ECHOING DAY OF THE MONTH THE USE US BORN ON
####################################################################






echo -n "You were born on a " 
	date -d "$year-$month-$day" +%A

printf  "Your Chinese sign is $elemental_type $symbol" | figlet

#printf "Your Element type is $element" | figlet

fortune





