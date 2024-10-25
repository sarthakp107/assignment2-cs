//104817068
//sarthak pradhan

main: 
bl askForName
play:
str r3 , .ClearScreen
mov r0, #10
mov r1, #100
bl matchstickToStartWith
mov r0, r5
bl playerTurn

halt

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
str r3, .ClearScreen
bl drawing
ret

//display player name and matchsticks

displayPlayerInfo:
push {lr}
    mov r4, #nameOutput
    str r4, .WriteString       // "player 1 is "
    mov r5, #myName
    str r5, .WriteString       // display player's name
    mov r6, #matchsticksOutput
    str r6, .WriteString       // display matchsticks message
    str r7, .WriteSignedNum    // show number of matchsticks
    bl drawing
    pop {r3}
    pop {lr}
    pop {lr}
    ret


//function for players turn
playerTurn:
push {r3,r4,r5,r6}

mov r3, #dis1 //player
str r3, .WriteString
mov r4 , #myName   //stored player name
str r4, .WriteString 

mov r5, #dis2 //there are
str r5, .WriteString

mov r5, r7 // Remaining matchsticks
    str r5, .WriteSignedNum

mov r5 , #dis3
str r5, .WriteString

 // Ask how many matchsticks to remove
    mov r3, #question1
    str r3, .WriteString   // "How many do you want to remove?"
    ldr r8, .InputNum      // get user input

mov r3, #dis4 //you choose
str r3, .WriteString
str r8, .WriteSignedNum
mov r3, #newLine
str r3, .WriteString

mov r5 , #1 
mov r6 , #7 
cmp r8 , r5
blt playerTurn
cmp r8, r6
bgt playerTurn
//cant remove more than the remaining matchsticks aswell
cmp r8, r7
bgt playerTurn

//update the remaining matchsticks
sub r7, r7 , r8
//mov r0,r7
push {lr}
bl displayRemainingMatch
pop {lr}
str r3, .ClearScreen
bl drawing

cmp r7, #0
beq draw
cmp r7, #1
beq win
b computerTurn

pop {r3,r4,r5,r6}
ret

//display remaining matchsticks
displayRemainingMatch:
push {r3,r4,lr}
mov r3, r7
str r3, .WriteSignedNum
mov r4 , #dis3
str r4, .WriteString
pop {r3,r4,lr}
ret

/////////////////////////////////////////////////////////

computerTurn:
mov r0, #disBot1
str r0, .WriteString

//display the remaining matchsticks
bl displayRemainingMatch

//random number to remove the matchstick (bot input)
random:
ldr r1, .Random //generate random number
and r1 , r1 , #7 //limit the value to a range.. 0-7
cmp r1, #0 //if the random number === 0 regenerate the number
beq random
cmp r1,r7
bgt random //if random number > remaining matchsticks .. regenerate
//else
mov r2, #disBot2 //computer choose to remove
str r2, .WriteString
str r1, .WriteSignedNum
mov r2, #macthstickOutputNoSpace
str r2 , .WriteString

sub r7,r7,r1 //subtract matchsticks from the bot input


str r7, .WriteSignedNum //remaining matchsticks
mov r2, #dis3
str r2, .WriteString

str r3, .ClearScreen
bl drawing

cmp r7, #1
beq lose
bgt playerTurn

cmp r7, #1
beq win

cmp r7,#0
beq draw

/////////////////////////////////////////////////////////

win:
mov r1, #dis1 //player
str r1, .WriteString
str r4, .WriteString //stored player name
mov r2, #disWin
str r2, .WriteString
b gameover

lose:
mov r6, #dis1 //player
str r6, .WriteString
str r4, .WriteString //stored player name
mov r2, #disLose
str r2, .WriteString
b gameover

draw:
mov r2, #disDraw
str r2, .WriteString
b gameover

gameover:
mov r1, #gameFinish
str r1, .WriteString
mov r2, #yesORno
str r2, .ReadString

ldrb r2,[r2] //to load first byte of the input

cmp r2, #121 //ascii number for "y"
beq play
cmp r2, #110 //ascii number for "n"
beq stop
b gameover


stop:
str r3, .ClearScreen
halt 

//function for drawing mid-res.... 64col, 48rows
drawing:
push {r1,r2,r4,r5,r6,r9,r10,r11}
mov r0, #1 //x coordinate
mov r1 , #1 //y coordinate

mov r9, #0 //initializing number of matchsticks drawn


//label to draw the matchstick
drawMatchStick:
mov r3, #.PixelScreen 
//drawing the red part of the matchstick
mov r2, #.red
lsl r4, r0, #2 //increasing x-coordinate by 4
lsl r5,r1, #8 //y-coordinate by 256
add r5,r5,r4
str r2, [r3+r5]

//drawing the body
mov r2, #.sandybrown

mov r8, #3

matchstickBody:
add r0,r0,#1 //increasing x-coordinate by 1 pixel
lsl r4,r0,#2
lsl r5,r1,#8
add r5,r5,r4 //get the pixel index
//draw the body
str r2, [r3+r5]


sub r8,r8,#1 //decreamenting pixel count and branching if greater than 0
cmp r8, #0
bgt matchstickBody

//move to the next matchstick by adding 3 to r0 as r0 = 1, 1+3=4
add r0,r0,#3
add r9,r9,#1 //adding number of matchsticks drawn
add r10,r10,#1

cmp r9,r7
beq endDraw

//to check if we need a new line
cmp r10, #10
beq newLineScreen
b drawMatchStick

newLineScreen:
add r1,r1,#4
mov r0,#1
add r11,r11,#1
mov r10,#0

cmp r11, #10
blt drawMatchStick


endDraw:
pop {r1,r2,r4,r5,r6,r9,r10,r11}
ret

//stage1
display1: .asciz "Please Enter Your Name\n"
display2: .asciz "How Many matchsticks (10-100)?\n" 
nameOutput: .asciz "Player 1 is "
matchsticksOutput: .asciz "\nMatchsticks: "
macthstickOutputNoSpace: .asciz " matchsticks\n"
myName: .BLOCK 128
numOfMatchsticks: .Word 0

//stage2
dis1: .asciz "\nPlayer "
dis2: .asciz ", there are "
dis3: .asciz " matchsticks remaining"
question1: .asciz ", how many do you want to remove (1-7)?\n"
dis4: .asciz "\nYou Choose: "
newLine: .asciz "\n"


//stage3
disBot1: .asciz "\nComputer Player's Turn\n"
disBot2: .asciz "\nComputer choose to remove "
disLose: .asciz ", YOU LOSE!!!\n"
disWin: .asciz ". YOU WIN!\n"
disDraw: .asciz "\n Its a draw!\n"
gameOver: .asciz "\n\nGAME OVER!\n\n"
gameFinish: .asciz "\nPlay again (y/n) ?\n"
yesORno: .BLOCK 128
