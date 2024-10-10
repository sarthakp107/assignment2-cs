mov r0, #display1
str r0, .WriteString //display 1
mov r1, #myName
str r1, .ReadString //gets the input from the user
mov r2, #display2 

loop1:              //for re displaying the number of matchsticks
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
cmp r3, #0
beq gameover
b playerTurn


gameover:
mov r12, #gameFinish
str r12, .WriteString

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
gameFinish: .asciz "\nGAME OVER!\n"