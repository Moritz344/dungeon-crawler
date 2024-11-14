#!/bin/bash

# Terminal konfigurieren
tput civis  # Cursor ausblenden

# Spielfeldgröße
ROWS=20
COLS=100

x=$(( COLS / 2))
y=$(( ROWS / 2))

DPOSITIONY=$(( 1 + RANDOM % 5))
DPOSITIONX=$(( 1 + RANDOM % 10))

ROCKPOSITIONX=$(( 1 + RANDOM % 5))
ROCKPOSITIONY=$(( 1 + RANDOM % 10))

COLLISIONX=$(( $ROCKPOSITIONX + 1 ))
COLLISIONX2=$(( $ROCKPOSITIONX - 1))

SCORE=0

rock() {
   # spieler ist rechts von rock
   # x: 20 ; rockx: 10
   if [[ $x -eq $COLLISIONX ]]; then
        if [[ $x > $ROCKPOSITIONX ]]; then
            x=$(( $x + 1))   
   # stein ist rechts von spieler
   # x: 10 ; rockx: 20
   if [[ $x -eq $COLLISIONX2 ]]; then
            if [ $x < $ROCKPOSITIONX ]; then
                x=$(( $x - 1))
   fi
   fi
   fi
   fi
    
   #if [[ $y < $ROCKPOSITIONY ]]; then
       #y=$(( $y - 1))
   #elif [[ $y > $ROCKPOSITIONY ]]; then
       #y=$(( $y + 1 ))
   #fi
}



coin() {

    if [[ $x -eq $DPOSITIONX && $y -eq $DPOSITIONY ]]; then
        # echo "Münze gefunden!"
        NEWX=$(( 1 + RANDOM % 10 ))
        NEWY=$(( 1 + RANDOM % 5 ))
        
        DPOSITIONX=NEWX
        DPOSITIONY=NEWY
            
        SCORE=$(( SCORE + 1 ))
    fi

}

randomCoin() {

        NEWX=$(( 1 + RANDOM % 10 ))
        NEWY=$(( 1 + RANDOM % 5 ))
        
        DPOSITIONX=NEWX
        DPOSITIONY=NEWY

}

drawField() {
    tput clear   
    echo $DPOSITION

    printf "x:$x y:$y"

    echo ""
    tput blink
    echo "SCORE: $SCORE"
    tput sgr0

    for (( i=0; i<$ROWS; i++ )); do
        for (( j=0; j<$COLS; j++ )); do
            if [[ $i -eq 0 || $i -eq $((ROWS-1)) || $j -eq 0 || $j -eq $((COLS-1)) ]]; then
                echo -n "#"
            elif [[ $i -eq $y && $j -eq $x ]]; then
                echo -n "@"
            elif [[ $i -eq $DPOSITIONY && $j -eq $DPOSITIONX ]]; then
                echo -n "M"
            elif [[ $i -eq $ROCKPOSITIONY && $j -eq $ROCKPOSITIONX ]]; then
                echo -n "-"
            else
                echo -n " "
            fi
        done
        echo
     done



}

worldGeneration() {


    # Begrenzung für Spielfeldgrenzen
    if [[ $x -lt 1 ]]; then 
        randomCoin
        x=97;fi
    if [[ $x -gt $(( COLS-2 )) ]]; then 
        randomCoin
        x=1
    fi
    if [[ $y -lt 1 ]]; then 
        randomCoin
        y=18; fi
    if [[ $y -gt $((ROWS-2)) ]]; then 
        randomCoin
        y=0 ; fi
    
}

movePlayer() {

    # Bewegung
    case $key in 
        w) ((y--)) ;;
        s) ((y++)) ;;
        a) ((x--)) ;;
        d) ((x++)) ;;
        q) break ;;
    esac


}


while true; do
    # echo "($x $y)"
    # echo "($NEWX $NEWY )"
    tput clear

    rock
    drawField
    read -t 5 -n 1 key  # Warten auf Tasteneingabe für 0,1 Sekunden
    #
       
    movePlayer
    worldGeneration
    coin


    
done

tput cnorm
tput clear

