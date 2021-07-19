.globl main
.data
input:
.string "Hello, world!"
.text
main:
    addi sp, sp, -128
    sw ra, 32(sp)
    sw a0, 0(sp)
    sw a1, 4(sp)
    sw a2, 8(sp)
    sw a3, 12(sp)
    
    sw a4, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)
    sw a7, 28(sp)
    
    sw s0, 36(sp)
    sw s1, 40(sp)
    sw s2, 44(sp)
    sw s3, 48(sp)
    sw s4, 52(sp)
    sw s5, 56(sp)
    sw s6, 60(sp)
    sw s7, 64(sp)
    sw s8, 68(sp)
    sw s9, 72(sp)
    sw s10, 76(sp)
    sw s11, 80(sp)
    
    sw t0, 84(sp)
    sw t1, 88(sp)
    sw t2, 92(sp)
    sw t3, 96(sp)
    sw t4, 100(sp)
    sw t5, 104(sp)
    sw t6, 108(sp)
    
    sw gp, 112(sp)
    
    mv t0, sp
    li t1, 0 # iter
    li t2, 8 # loop end
    
    li a7, 11
    li a0, 's'
    ecall
    li a7, 11
    li a0, 'p'
    ecall
    li a7, 11
    li a0, ':'
    ecall
    addi a0, sp, 128
    li a7, 34
    ecall
    li a7, 11
    li a0, '\n'
    ecall
    li a7, 11
    li a0, '\n'
    ecall
    
loop:
    beq t1, t2, printRa
    li a7, 11
    li a0, 'a'
    ecall
    li a7, 1
    mv a0, t1 
    ecall
    li a7, 11
    li a0, ':'
    ecall
    lw a0, 0(t0)
    li a7, 34
    ecall
    li a7, 11
    li a0, '\n'
    ecall
    addi t0, t0, 4
    addi t1, t1, 1
    j loop

printRa:
    li a7, 11
    li a0, '\n'
    ecall
    
    li a7, 11
    li a0, 'r'
    ecall
    li a0, 'a'
    ecall
    li a7, 11
    li a0, ':'
    ecall
    lw a0, 0(t0)
    li a7, 34
    ecall
    li a7, 11
    li a0, '\n'
    ecall
    addi t0, t0, 4
    
    li a7, 11
    li a0, '\n'
    ecall
    
    li t1, 0 # iter
    li t2, 12 # loop end
    
printSaved:
    beq t1, t2, exitSaved
    li a7, 11
    li a0, 's'
    ecall
    li a7, 1
    mv a0, t1 
    ecall
    li a7, 11
    li a0, ':'
    ecall
    lw a0, 0(t0)
    li a7, 34
    ecall
    li a7, 11
    li a0, '\n'
    ecall
    addi t0, t0, 4
    addi t1, t1, 1
    j printSaved

exitSaved:
    li a7, 11
    li a0, '\n'
    ecall
    
    li t1, 0 # iter
    li t2, 7 # loop end
    
printTemp:
    beq t1, t2, end
    li a7, 11
    li a0, 't'
    ecall
    li a7, 1
    mv a0, t1 
    ecall
    li a7, 11
    li a0, ':'
    ecall
    lw a0, 0(t0)
    li a7, 34
    ecall
    li a7, 11
    li a0, '\n'
    ecall
    addi t0, t0, 4
    addi t1, t1, 1
    j printTemp

end:    
    lw ra, 32(sp)
    lw a0, 0(sp)
    lw a1, 4(sp)
    lw a2, 8(sp)
    lw a3, 12(sp)
    
    lw a4, 16(sp)
    lw a5, 20(sp)
    lw a6, 24(sp)
    lw a7, 28(sp)
    
    lw s0, 36(sp)
    lw s1, 40(sp)
    lw s2, 44(sp)
    lw s3, 48(sp)
    lw s4, 52(sp)
    lw s5, 56(sp)
    lw s6, 60(sp)
    lw s7, 64(sp)
    lw s8, 68(sp)
    lw s9, 72(sp)
    lw s10, 76(sp)
    lw s11, 80(sp)
    addi sp, sp, 128
    # Exit (93) with code 0
    li a0, 0
    li a7, 93
    ecall
    ebreak
 
