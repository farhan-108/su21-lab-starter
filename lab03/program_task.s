# Define data section (if needed)
.data

# Initialize variables
a:      .word   7           # a = 7
b:# Array b of 3 integers
    .word 0
    .word 0
    .word 0

# Define text section (main program)
.text
# Initialize variables
        lw      s1, a       # Load 'a' into register s1 (s1 = a)
        la      s2, b       # Load the address of 'b' into register s2

# Initialize loop counter
        li      s0, 0       # Initialize loop counter i to 0 (s0 = 0)
        addi t1 ,zero,3     #t1 = 3

# Loop start
loop:
        bge     s0, t1, done # Exit the loop if i >= t1 or 3

        # Calculate b[i] = a + (i * a) and store it in memory
        mul     t0,s0,s1    # Calculate(i * a)
        add     t0, t0, s1  # Calculate a + (i * a)
        sw      t0, 0(s2)   # Store the result in b[i]
        # Print the integer result
        mv a1, t0
        ecall # Print Result
        
        # Increment i (s0)
        addi    s0, s0, 1   # Increment i

        j       loop         # Jump back to the beginning of the loop

# Loop end
done:
        addi a0, x0, 10 #terminate the program
        ecall 
        
