.globl main
.text
main:
    # This program takes one command-line argument. It gets rid of repeated characters

    # s0 -> argv
    # s1 -> argv plus iterator
    # s2 -> contains individual argv characters
    # s3 -> boolean flag true if repeated characters
    # s4 -> address of the linked list that contains visited characters
    # s5 -> address of the visited characters linked list + interator
    # s6 -> contains visited characters
    
    li t0, 1 # t0 <- 1
    bne a0, t0, error # if argc != 1: goto error

    # Save saved registers on stack
    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    
    # zero out all the saved registers and t0
    mv t0, zero
    mv s0, zero
    mv s1, zero
    mv s2, zero
    mv s3, zero
    mv s4, zero
    mv s5, zero
    mv s6, zero
    
    # load argc into registers
    lw s0, 0(a1) # s0 <- &argv[0]  # uncomment
    mv s1, s0 # s1 <- &argv[0]
    
    # load head of the linked list
    li a7, 9
    li a0, 8 # allocating 8 bytes on the heap
    ecall
    mv s4, a0 # s4 <- linkedListHead
    
    # Making sure the heap memory is initialized to all zeroes
    sw zero, 0(s4)
    sw zero, 4(s4)
    
loopOverArgv:
    mv s5, s4 # s5 (node iter) <- linkedListHead
    
    lb s2, 0(s1) # s2 <- argv[i]
    beqz s2, endLoopOverArgv # if argv[i] == '\0': goto end of loop
    
    # make sure isRepeated (s3) is zero
    mv s3, zero # s3 <- 0
    
        
loopOverVisitedList: # loop over visited characters linked list

    lw t0, 4(s5) # t0 <- next pointer
    beqz t0, endLoopOverVisitedList # if next pointer is null, then exit
    
    lb s6, 0(s5) # s6 <- linkedListNode->data
    
    bne s2, s6, charsDifferent # if argv[i] == linkedList[j]: goto else
    li s3, 1 # isRepeated = true
    j endLoopOverVisitedList # BREAK out of loop
    
charsDifferent:
     
    # goto next in linked list
    lw t0, 4(s5) # can you do this in one line?
    mv s5, t0
     
    j loopOverVisitedList
    
endLoopOverVisitedList:
    # Create a new entry in the linked list if not isRepeated
    
    bnez s3, elseIsRepeated # if isRepeat: goto else
     
    sb s2, 0(s5) # linkedListNode->data <- argv[i]
    
    # create a new tail in the linked list
    li a7, 9 # heap allocation
    li a0, 8 # allocating 8 bytes on the heap
    ecall
    
    sw a0, 4(s5) # linkdListNode->next <- malloc()
    # Make sure the heap memory is initialized to all zeroes
    sw zero, 0(a0)
    sw zero, 4(a0)
    
    # print the char
    li a7, 11
    mv a0, s2
    ecall
    
elseIsRepeated:    
    addi s1, s1, 1 # i++
    j loopOverArgv

endLoopOverArgv:
    
end:
    # print a newline character
    li a7, 11
    li a0, '\n'
    ecall
    
    # unload saved registers from stack
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    addi sp, sp, 32
    
    # Exit with an error code of 0, no errors
    li a0, 0
    li a7, 93
    ecall 
    
    
 error:
    # Exit with an error code of 1, bad arguments
    li a0, 1
    li a7, 93
    ecall 
