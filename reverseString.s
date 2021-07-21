.globl main
.text
main:
    # This program takes one command-line argument. It reverses the input string

    # s0 -> argv (number of command line arguments)
    
    li t0, 1 # t0 <- 1
    bne a0, t0, error # if argc != 1: goto error

    # Save saved registers on stack
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw a1, 12(sp)
    
    lw s0, 0(a1) # s0 <- &argv[0]
    mv s1, s0 # s1 <- &argv[0]
    
findStringEnd:
    lb s2, 0(s0) # s2 = argv[0][0]
    beqz s2, printReverse # if s2 == nullChar: goto end
    
    addi s0, s0, 1 # s0 = &argv[0][++i]
    j findStringEnd

printReverse:
    addi s0, s0, -1 # s0 = &argv[0][--i]
    blt s0, s1, end  # if s2 == nullChar: goto end
    
    # print char
    li a7, 11
    lb a0, 0(s0)
    ecall
    
    j printReverse
    
end:
    # print a newline character
    li a7, 11
    li a0, '\n'
    ecall
    # unload saved registers from stack
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw a1, 12(sp)
    addi sp, sp, 16
    
    # Exit with an error code of 0, no errors
    li a0, 0
    li a7, 93
    ecall 
    
    
 error:
    # Exit with an error code of 1, bad arguments
    li a0, 1
    li a7, 93
    ecall 
