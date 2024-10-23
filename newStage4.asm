//104817068

main: 
bl askForName
mov r0, #10
mov r1, #100
bl matchstickToStartWith
mov r0, r5
mov r1, #1
mov r2, #7
bl playerTurn

halt

//r5,r7



//function to ask name
askForName:
push {r4 }
mov r4, #display1
str r4, .WriteString
mov r5, #myName
str r5, .ReadString //gets the input from the user
pop {r4 }
ret

//function for asking how many matchsticks to play with
matchstickToStartWith:
push {r3 , lr} 
mov r3, #display2             
str r3, .WriteString //display 2
mov r7, #numOfMatchsticks
ldr r7, .InputNum
cmp r7,r0
blt matchstickToStartWith
cmp r7,r1
bgt matchstickToStartWith
bl displayPlayerInfo
ret


////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


//display player name and matchsticks

displayPlayerInfo:
push {lr}
    mov r4, #nameOutput
    str r4, .WriteString       // "Player 1 is "
    mov r5, #myName
    str r5, .WriteString       // Display player's name
    mov r6, #matchsticksOutput
    str r6, .WriteString       // Display matchsticks message
    str r7, .WriteSignedNum    // Show number of matchsticks
    pop {r3}
    pop {lr}
    pop {lr}
    ret


////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

//display the remaining number of matchsticks
//Player <name>, there are <X> matchsticks remaining 

playerTurn:
push {r3,r4,r5,r6}

//displays this: Player <name>, there are <X> matchsticks remaining 
mov r3, #dis1 //player
str r3, .WriteString
mov r4 , #myName   //stored player name
str r4, .WriteString 

mov r5, #dis2 //there are
str r5, .WriteString
str r7, .WriteSignedNum //remaining matchsticks
mov r5 , #dis3
str r5, .WriteString
////////////////////
 // Ask how many matchsticks to remove
    mov r3, #question1
    str r3, .WriteString   // "How many do you want to remove?"
    ldr r8, .InputNum      // Get user input

mov r5 , r1 //1
mov r6 , r2 //7
cmp r8 , r5
blt playerTurn
cmp r8, r6
bgt playerTurn
//cant remove more than the remaining matchsticks aswell
cmp r8, r7
bgt playerTurn

//update the remaining matchsticks
sub r7, r7 , r8
mov r0,r7
push {lr}
bl displayRemainingMatch
pop {lr}
cmp r7, #0
beq gameover
cmp r7, #1
beq win
b playerTurn

pop {r3,r4,r5,r6}
ret

//display remaining matchsticks
displayRemainingMatch:
push {r3,r4,lr}
mov r3, r0
mov r4, #dis2 //there are
str r4, .WriteString
str r3, .WriteSignedNum
mov r4 , #dis3
str r4, .WriteString
pop {r3,r4,lr}
ret




win:
mov r1, #dis1 //player
str r1, .WriteString
str r4, .WriteString //stored player name
mov r2, #disWin
str r2, .WriteString
b gameover

gameover:
mov r1, #gameFinish
str r1, .WriteString
mov r2, #yesORno
str r2, .ReadString

//stage1
display1: .asciz "Please Enter Your Name\n"
display2: .asciz "How Many matchsticks (10-100)?\n" 
nameOutput: .asciz "Player 1 is "
matchsticksOutput: .asciz "\nMatchsticks: "
myName: .BLOCK 128
numOfMatchsticks: .Word 0

//stage2
dis1: .asciz "\nPlayer "
dis2: .asciz ", there are "
dis3: .asciz " matchsticks remaining."
question1: .asciz ", how many do you want to remove (1-7)?"


//stage3
disBot1: .asciz "\nComputer Player's Turn\n"
disBot2: .asciz "\nComputer choose to remove "
disLose: .asciz ", YOU LOSE!!!\n"
disWin: .asciz ". YOU WIN!\n"
disDraw: .asciz "\n Its a draw!\n"
gameOver: .asciz "\n\nGAME OVER!\n\n"
gameFinish: .asciz "\nPlay again (y/n) ?\n"
yesORno: .BLOCK 128
