.globl main
.text
main:
    # This program takes two arguments. It shows the second 
    # and then on a separate line shows the first

    # s0 -> argv
    
    li t0, 2 # t0 <- 2
    bne a0, t0, error # if argc != 2: end

    # Save saved registers on stack
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw a1, 12(sp)
    
    mv s0, a1 # s0 <- argv
    
    # print the first argument, argv[0]
    li a7, 4
    lw a0, 4(s0)
    ecall
    
    # print newline character
    li a7, 11
    li a0, '\n'
    ecall
    
    # print the first argument, argv[1]
    li a7, 4
    lw a0, 0(s0)
    ecall

end:
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
