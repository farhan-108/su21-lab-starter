.data
num: .word 8         # Initialize num with the desired input
result: .word 0       # Initialize result to 0
.text
.globl _start
_start:
    la t1, tohost
    li t2, 1
    sw t2,0(t1)
    # Load the input number (num) and the result address into registers
    la a1, num         # Load the address of num into a1
    lw a0, 0(a1)       # Load the value of num into a0
    la a2, result      # Load the address of result into a2

    # Call the factorial function
    jal ra, factorial

    # Load the result from memory to a0
    lw a0, 0(a2)

    # Terminate the program
    li a0, 10           # Load the exit syscall number (93 for program termination)
    #ecall

# Recursive factorial function
factorial:
    # Function prologue
    addi sp, sp, -8     # Allocate space on the stack for two words
    sw ra, 4(sp)        # Save the return address
    sw a0, 0(sp)        # Save num on the stack
    # Check if num <= 1
    li t1, 1
    bgt a0, t1, greater_than_one
    li a0, 1            # If num <= 1, return 1
    ecall
    j done

greater_than_one:
    # Recursive case: num * factorial(num - 1)
    li t2, 1            # Load 1 into t2
    addi a0, a0, -1      # num - 1
    jal ra, factorial   # Recursive call
    lw a0, 0(sp)        # Load num from the stack
    mul a0, a0, a0      # a0 = num * result
done:
    # Function epilogue
    lw a0, 0(sp)        # Restore num from the stack
    lw ra, 4(sp)        # Restore the return address
    addi sp, sp, 8      # Deallocate stack space
    jr ra              # Return to the caller
    addi a0,x0,1
    ecall

.align 8
.section ".tohost","aw",@progbits;                            
.align 4; .global tohost; tohost: .dword 0;                     
.align 4; .global fromhost; fromhost: .dword 0;
