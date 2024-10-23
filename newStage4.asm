//104817068

main: 
bl askForName
mov r0, #10
mov r1, #100
bl matchstickToStartWith
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
mov r3, #numOfMatchsticks
ldr r3, .InputNum
cmp r3,r0
blt matchstickToStartWith
cmp r3,r1
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
    str r3, .WriteSignedNum    // Show number of matchsticks
    pop {r3}
    pop {lr}
    pop {lr}
    ret


////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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
