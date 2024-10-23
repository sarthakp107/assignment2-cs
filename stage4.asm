
main:
bl askForName
bl matchstickToStartWith
//validation
mov r0, #10
mov r1, #100
bl validatingMatchsticksEnteredByTheUser
bl displayResults

halt
//to display the player name
mov r4 , #nameOutput
str r4, .WriteString
str r5, .WriteString

// to display the matchsticks
mov r5, #matchsticksOutput
str r5, .WriteString
str r3, .WriteSignedNum







//use input 



//function for asking user name
askForName:
push {r4}
mov r4, #display1
str r4, .WriteString
mov r5, #myName
str r5, .ReadString //gets the input from the user
pop {r4}
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

//function for asking how many matchsticks to play with
matchstickToStartWith:
push {r3}
loop1:
mov r3, #display2             
str r3, .WriteString //display 2
mov r3, #numOfMatchsticks
ldr r3, .InputNum
cmp r3,r0
blt loop1
cmp r3,r1
bgt loop1
pop {r3}
ret



//display function

displayResults:
push {r3,r4,r5,lr}
mov r4 , #nameOutput
str r4, .WriteString
str r5, .WriteString

// to display the matchsticks
mov r5, #matchsticksOutput
str r5, .WriteString
str r3, .WriteSignedNum
pop {r3,r4,r5,lr}
ret










display1: .asciz "Please Enter Your Name\n"
display2: .asciz "How Many matchsticks (10-100)?\n" 
nameOutput: .asciz "Player 1 is "
matchsticksOutput: .asciz "\nMatchsticks: "
myName: .BLOCK 128
numOfMatchsticks: .Word 0