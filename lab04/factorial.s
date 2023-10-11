.globl _start
.text              
#// start code here
#// Insert your code here
_start:
    la a0, num
    lw s1, 0(a0)
    la a1, result

    jal ra, rec_loop

    mul t0, t0, s1
    sw t0, 0(a1)
    j write_tohost

rec_loop: 
    addi sp, sp, -4
    sw s1, 0(sp)
    lw s1, 0(sp)
    addi sp, sp, 4
    li t0, 1
    beq s1, x0, next
    addi sp, sp, -8
    sw s1, 0(sp)
    sw ra, 4(sp)
    addi s1, s1, -1
    jal rec_loop
    mul t0, t0, s1
    
next:
    lw s1, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
    jr ra
#// end code here

write_tohost:
li x1, 1
sw x1, tohost, t5
j write_tohost


.data 
#// start data section here      
#// Initialize data here (if required)
num: .word 8
result: .word 0
#// end data section here

.align 8
.section ".tohost","aw",@progbits;                            
.align 4; .globl tohost; tohost: .dword 0;                     
.align 4; .globl fromhost; fromhost: .dword 0;
