.globl main
.text
main:
    # This program takes one command-line argument. It returns a fibonacci number up to the argument

    # s0 -> argv[0]
    # s1 -> iter
    # s2 -> int(argv[0])
    # s3 -> copy of argv[0]
    
    li t0, 1 # t0 <- 1
    bne a0, t0, error # if argc != 1: goto error

    # Save saved registers on stack
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    
    # zero out all the saved registers and t0-t4
    mv t0, zero
    mv t1, zero
    mv t2, zero
    mv t3, zero
    mv t4, zero
    mv s0, zero
    mv s1, zero
    mv s2, zero
    mv s3, zero
    
    # load argv into registers
    lw s0, 0(a1) # s0 <- &argv[0]
    mv s3, s0
        
    # determine if argv[0] is a number & get len(argv[0])
L1:
    lb t0, 0(s0) # t0 <- argv[0][i]
    beqz t0, LE1 # if argv[0][i] == '\0': goto end of loop
    
    # t2 = 10 digits and 48 is the ascii value of '0'
    li t2, 10 # t2 <- 10
    
    addi t0, t0, -48 # t0 <- t0 - 48
    bltz t0, notIntError # if t0 < 0: goto not an int error
    bge t0, t2, notIntError # if t0 >= 10: goto not an int error   
    
    addi s1, s1, 1 # iter++
    addi s0, s0, 1 # s0 = argv[0][++i]
    j L1    
LE1:
    mv s0, s3 # s0 gets &argv[0]
    addi s1, s1, -1 # len(argv[0]) -= 1
    
L3:
    lb t0, 0(s0) # t0 <- argv[0][i]
    beqz t0, LE3 # if a[0][i] != '\0': goto end of loop        
 
    li t0, 10 # 10
    li t1, 1 # init the result variable for 10^exponent
    mv t2, s1 # t2 <- exponent 
    mv t3, zero # j = 0
L2:
    bge t3, t2, LE2 # if t3 >= expo: break
    mul t1, t1, t0 # res *= 10
    addi t3, t3, 1 # j++ 
    j L2
LE2:
    lb t0, 0(s0) # t0 <- argv[0][i]
    addi t0, t0, -48 # t0 <- t0 - 48 ;t0 - int('0')
    
    mul t0, t0, t1 # int value * 100 or 10 or 1 etc.
    add s2, s2, t0 # registerValueOfTheInt += IntValueOfTheDigit
    
    addi s1, s1, -1 # --expo
    addi s0, s0, 1 # argv[i++]
    j L3
LE3:
         
    beqz s2, end # if valueOfTheInt == 0: goto end
    li t0, 1 # t0 <- 1
    beq s2, t0, end # if valueOfTheInt == 1: goto end
    
    # print a 1
    li a7, 1 # printInt syscall
    li a0, 1 # value to print
    ecall
    
    li a7, 11 # printChar syscall
    li a0, '\n' # print a newline character
    ecall 
    
    # Here's where I do fibonacci sequence
    mv t0, zero # t0 <- 0
    li t1, 1 # t1 <- 1
L4:
    add t3, t1, t0 # t3 <- t1 + t2
    sub t4, t3, s2 # t4 <- t3 - argAsInt
    bgez t4, LE4 # if t4 >= 0: break out of loop
    
    li a7, 1 # printInt syscall
    mv a0, t3 # print t3 (current fib number)
    ecall 
    
    li a7, 11 # printChar syscall
    li a0, '\n' # print newline character
    ecall 
    
    mv t0, t1 # t0 <- t1
    mv t1, t3 # t1 <- t3
    
    j L4
LE4:    
    
end:
    # unload saved registers from stack
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    addi sp, sp, 16
    
    # Exit with an error code of 0, no errors
    li a0, 0
    li a7, 93
    ecall 
    
    
 error:
    # Exit with an error code of 1, incorrect number of arguments
    li a0, 1
    li a7, 93
    ecall 
    
 notIntError:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    addi sp, sp, 16
 
    # Exit with an error code of 2, argument is not an int
    li a0, 2
    li a7, 93
    ecall 
