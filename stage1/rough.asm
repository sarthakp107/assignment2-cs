  1|      mov r0, #15 
  2|Loop: 
  3|      str r0, .WriteSignedNum 
  4|      mov r1, #dp1 
  5|      str r1, .WriteString 
  6|      mov r2, #dp2 
  7|      B Loop2 
  8|select: 
  9|      str r0, .WriteSignedNum 
 10|      mov r1, #dp1 
 11|      str r1, .WriteString 
 12|      mov r7, #dp4 
 13|      str r7, .WriteString 
 14|select_again: 
 15|      ldr r6, .Random 
 16|      AND R6,R6,#3 
 17|      CMP R6, #0 
 18|      BGT select2 
 19|      B select_again 
 20|select2: 
 21|      cmp r6, r0 
 22|      bgt select 
 23|      sub r0,r0,r6 
 24|      cmp r0,#0 
 25|      BEQ prompt1 
 26|      BGT Loop 
 27|prompt1: 
 28|      mov r12, #dp5 
 29|      str r12, .WriteString 
 30|      halt 
 31|prompt2: 
 32|      mov r12, #dp6 
 33|      str r12, .WriteString 
 34|      halt 
 35|Loop2: 
 36|      str r2, .WriteString 
 37|      mov r3, #num 
 38|      ldr r3, .InputNum 
 39|      cmp r3, #1 
 40|      blt Loop2 
 41|      b condition1 
 42|condition1: 
 43|      cmp r3,#3 
 44|      bgt Loop2 
 45|      b condition2 
 46|condition2: 
 47|      sub r0,r0,r3 
 48|      cmp r0,#0 
 49|      beq prompt2 
 50|      bgt select 
 51|      mov r4,#dp3 
 52|      str r4, .WriteString 
 53|      halt 
 54|dp1:  .asciz "remaining\n" 
 55|dp2:  .asciz "How many do you want to remove (1-3)?\n" 
 56|dp3:  .asciz "None left!" 
 57|dp4:  .asciz "Computers Turn\n" 
 58|dp5:  .asciz "You Win\n" 
 59|dp6:  .asciz "You loose\n" 
 60|num:  .word 0 
