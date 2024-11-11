#!/bin/bash

# Terminal konfigurieren
tput civis  # Cursor ausblenden

# Spielfeldgröße
ROWS=20
COLS=100

x=ROWS // 2 
y=COLS // 2

DPOSITIONY=$(( 1 + RANDOM % 5))
DPOSITIONX=$(( 1 + RANDOM % 10))

SCORE=0



drawField() {
    tput clear   
    echo $DPOSITION

    echo "SCORE: $SCORE"

    for (( i=0; i<$ROWS; i++ )); do
        for (( j=0; j<$COLS; j++ )); do
            if [[ $i -eq 0 || $i -eq $((ROWS-1)) || $j -eq 0 || $j -eq $((COLS-1)) ]]; then
                echo -n "#"
            elif [[ $i -eq $y && $j -eq $x ]]; then
                echo -n "@"
            elif [[ $i -eq $DPOSITIONY && $j -eq $DPOSITIONX ]]; then
                echo -n "M"
            else
                echo -n " "
            fi
        done
        echo
     done



}

while true; do
    # echo "($x $y)"
    # echo "($NEWX $NEWY )"
    tput clear
    drawField
    read -t 5 -n 1 key  # Warten auf Tasteneingabe für 0,1 Sekunden
    #
    if [[ $x -eq $DPOSITIONX && $y -eq $DPOSITIONY ]]; then
        # echo "Münze gefunden!"
        NEWX=$(( 1 + RANDOM % 10 ))
        NEWY=$(( 1 + RANDOM % 5 ))
        
        DPOSITIONX=NEWX
        DPOSITIONY=NEWY
            
        SCORE=$(( SCORE + 1 ))
    fi
       
    # Bewegung
    case $key in 
        w) ((y--)) ;;
        s) ((y++)) ;;
        a) ((x--)) ;;
        d) ((x++)) ;;
        q) break ;;
    esac


    # Begrenzung für Spielfeldgrenzen
    if [[ $x -lt 1 ]]; then 
        x=1; fi
    if [[ $x -gt $((COLS-2)) ]]; then 
        x=$((COLS-2)); fi
    if [[ $y -lt 1 ]]; then 
        y=1; fi
    if [[ $y -gt $((ROWS-2)) ]]; then 
        y=$((ROWS-2)); fi

    
done

tput cnorm
tput clear

