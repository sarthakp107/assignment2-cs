mov r0, #display1
str r0, .WriteString //display 1
mov r1, #myName
str r1, .ReadString //gets the input from the user
mov r2, #display2 

loop1:              //for re displaying the number of matchsticks
mov r2, #display2 
str r2, .WriteString //display 2
mov r3, #numOfMatchsticks
ldr r3, .InputNum       // r3 has number of matchsticks
cmp r3,#10
blt loop1
cmp r3,#100
bgt loop1

//to display the player name
mov r4 , #nameOutput
str r4, .WriteString
str r1, .WriteString

// to display the matchsticks
mov r5, #matchsticksOutput
str r5, .WriteString
str r3, .WriteSignedNum

//display the remaining number of matchsticks
mov r6, #dis1 //player
str r6, .WriteString
str r1, .WriteString //stored player name

mov r7, #dis2
str r7, .WriteString

str r3, .WriteSignedNum //remaining matchsticks
mov r8, #dis3
str r8, .WriteString

//askes how many matchsticks to remove?
playerTurn:
str r6, .WriteString
str r1, .WriteString //stored player name
mov r9, #question1
str r9, .WriteString
//takes the input from the user
ldr r10, .InputNum
//validating if the input is between 1 and 7
cmp r10, #1
blt playerTurn
cmp r10, #7
bgt playerTurn
//validating if the input is not larger than current number of matchsticks
cmp r10, r3
bgt playerTurn

//if the input is between 1 and 7 proceed to update the number of matchsticks
sub r3, r3 , r10 //gets the remainder

mov r6, #dis1 //player
str r6, .WriteString
str r1, .WriteString //stored player name

mov r7, #dis2
str r7, .WriteString

str r3, .WriteSignedNum //remaining matchsticks
mov r8, #dis3
str r8, .WriteString

//repeat until matchstick == 0
cmp r3, #1
beq win
b computerTurn


//computers turn
computerTurn:
mov r0, #disBot1
str r0, .WriteString

//display the remaining matchsticks
mov r7, #dis2
str r7, .WriteString

str r3, .WriteSignedNum //remaining matchsticks
mov r8, #dis3
str r8, .WriteString

//random number to remove the matchstick (bot input)
random:
ldr r12, .Random //generate random number
and r12 , r12 , #7 //limit the value to a range.. 0-7
cmp r12, #0 //if the random number == 0 regenerate the number
beq random
cmp r12,r3 
bgt random //if random number > remaining matchsticks .. regenerate
//else
mov r2, #disBot2
str r2, .WriteString
str r12, .WriteSignedNum

sub r3,r3,r12 //subtract matchsticks from the bot input

mov r7, #dis2
str r7, .WriteString

str r3, .WriteSignedNum //remaining matchsticks
mov r8, #dis3
str r8, .WriteString

cmp r3, #1
beq lose
bgt playerTurn

cmp r3, #1
beq win

cmp r3,#0
beq draw


win:
mov r6, #dis1 //player
str r6, .WriteString
str r1, .WriteString //stored player name
mov r2, #disWin
str r2, .WriteString
b gameover


lose:
mov r6, #dis1 //player
str r6, .WriteString
str r1, .WriteString //stored player name
mov r2, #disLose
str r2, .WriteString
b gameover

draw:
mov r2, #disDraw
str r2, .WriteString
b gameover

gameover:
mov r12, #gameFinish
str r12, .WriteString
mov r7, #yesORno
str r7, .ReadString

ldrb r7,[r7] //to load first byte of the input

cmp r7, #121 //ascii number for "y"
beq loop1
cmp r7, #110 //ascii number for "n"
beq stop
b gameover

stop:
halt

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
gameFinish: .asciz "\nPlay again (y/n) ?\n"
yesORno: .BLOCK 128
