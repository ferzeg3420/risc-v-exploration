.globl main
.data
input:
.string "Hello, world!"
.text
main:
    # This is probably done better by having 
    # two copies of the input's address and substracting at the end
    
    # s0 is count of chars
    # s1 is the temp char
    # s2 is the iterator/memory location of the input string
    
    # Save the registers I'm going to use.
    addi sp, sp, -12
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    
    # Making sure my registers are empty
    mv s0, zero
    mv s1, zero
    mv s2, zero
    
    la s2, input # s2 = &A[0]
    
loop:
    lb s1, 0(s2) # s1 = A[i]
    beqz s1, output # if s1 == 0: goto output
    
    # print the char
    mv a0, s1
    li a7, 11
    ecall
    
    addi s0, s0, 1 # count++
    addi s2, s2, 1 # i++ (s2 = &A[++i])
    j loop
    
output:
    # Print the count of characters
    mv a0, s0
    li a7, 1
    ecall
    
    # Empty stack 
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    addi sp, sp, 12
    
    # Exit with an error code of 42 for no reason 
    li a0, 42
    li a7, 93
    ecall 
