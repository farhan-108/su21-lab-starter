.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    # Multiply t0 (result) by a0
    addi t0, x0, 1
    factorial_loop:
    mul t0, t0, a0
    
    # Decrement a0 by 1
    addi a0, a0, -1
    
    # Check if a0 is greater than 1, if yes, continue the loop
    bnez a0, factorial_loop
    mv a0, t0
    ret
    
    