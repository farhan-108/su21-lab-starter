.globl main

.data
arr: .space 40    # Allocate space for the integer array (10 elements x 4 bytes each)
num: .word 7       # Initialize the variable num with value 7

.text
main:
    addi s0, x0, 10   # Initialize s0 to hold the number of iterations
    la t0, num        # Load the address of the variable num
    lw a0, 0(t0)      # Load the value of num into a0
    la s5, arr        # Load the address of arr into s5

dataArray:
    beqz s0, end      # Exit the loop if s0 is 0
    addi s0, s0, 1    # Decrement s0 (number of iterations)
    
    jal ra, compare   # Call the compare function
    
    sw a0, 0(s5)      # Store the result in the array (arr[i] = compare result)
    addi s5, s5, 4    # Update the array pointer

    j dataArray       # Repeat the loop

compare:
    bltz a0, next     # Branch to next if a0 is negative
    li a0, 1           # Set a0 to 1 (return 1)
    jr ra             # Return

next:
    li a0, 0           # Set a0 to 0 (return 0)
    jr ra             # Return

end:
    la s5, arr        # Reset the array pointer to the beginning
    
printArray:
    beqz s0, exitPrint  # Exit printing loop if s0 is 0
    lw a1, 0(s5)      # Load the value from the array
    addi s5, s5, 4    # Update the array pointer
    addi s0, s0, -1   # Decrement s0 (number of remaining elements to print)

    li a0, 1          # File descriptor for stdout
    li a2, 1          # Number of characters to write (1 character)
    li a7, 4          # Print integer system call code
    ecall             # Invoke the system call

    j printArray       # Repeat the loop

exitPrint:
    li a7, 10         # Exit program system call code
    ecall             # Terminate the program
