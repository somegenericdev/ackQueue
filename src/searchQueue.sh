#!/bin/bash

function get_index(){
for i in "${!argsArray[@]}"; do
   if [[ "${argsArray[$i]}" = "${1}" ]]; then
       echo "${i}";
   fi
done
}

len=${#@}
argsArray=("$@")
indexesArray=( $(seq 0 $count ) )
currentIdx=0
maxIndex=$(expr $len - 1)



ackBaseCmd='ack -A 4'

while getopts 'a:' OPTION; do
  case "$OPTION" in
    a)
      ackBaseCmd="$OPTARG"
      echo "The value provided is $OPTARG"
      #delete -a and the successive argument from the argsArray
      aFlagIndex=$(get_index "-a")
      unset "argsArray[$aFlagIndex]"
      unset "argsArray[$(expr $aFlagIndex + 1)]"
      argsArray=(${argsArray[@]})
      maxIndex=$(expr $maxIndex - 2)
      ;;
    ?) ;;
    
  esac
done



ackSecondPartCmd="${argsArray[$currentIdx]}"
ackCmd="$ackBaseCmd $ackSecondPartCmd"
echo $ackCmd
eval "$ackCmd"



while true; do
    read -rsn1 input
    if [ "$input" = "n" ] || [ "$input" = "N" ]; then
        if [ "$currentIdx" = "$maxIndex" ]; then
            currentIdx=0
        else
            currentIdx=$(expr $currentIdx + 1)
        fi
        clear
        ackSecondPartCmd='name=\"'"${argsArray[$currentIdx]}"'\"'
        #ackSecondPartCmd="${argsArray[$currentIdx]}"
        ackCmd="$ackBaseCmd $ackSecondPartCmd"
        echo $ackCmd
        eval "$ackCmd"
    elif [ "$input" = "b" ] || [ "$input" = "B" ]; then
        if [ "$currentIdx" = 0 ]; then
            currentIdx=$maxIndex
        else
            currentIdx=$(expr $currentIdx - 1)
        fi

        clear
        ackSecondPartCmd="${argsArray[$currentIdx]}"
        ackCmd="$ackBaseCmd $ackSecondPartCmd"
        echo $ackCmd
        eval "$ackCmd"
    elif [ "$input" = "m" ] || [ "$input" = "M" ]; then
        selectedElement=$(printf '%s\n' "${argsArray[@]}" | dmenu -l 10)
        currentIdx=$(get_index "$selectedElement")
        clear
        ackSecondPartCmd="${argsArray[$currentIdx]}"
        ackCmd="$ackBaseCmd $ackSecondPartCmd"
        echo $ackCmd
        eval "$ackCmd"
    else
        echo "input not valid"
    fi
done
