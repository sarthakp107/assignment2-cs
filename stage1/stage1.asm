mov r0, #display1
str r0, .WriteString //display 1
mov r1, #myName
str r1, .ReadString //gets the input from the user
mov r2, #display2 

loop1:              //for re displaying the number of matchsticks
str r2, .WriteString //display 2
mov r3, #numOfMatchsticks
ldr r3, .InputNum
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


halt
display1: .asciz "Please Enter Your Name\n"
display2: .asciz "How Many matchsticks (10-100)?\n" 
nameOutput: .asciz "Player 1 is "
matchsticksOutput: .asciz "\nMatchsticks: "
myName: .BLOCK 128
numOfMatchsticks: .Word 0