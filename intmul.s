// Replace this file with your own implementation
	.arch armv8-a
	.global intmul

intmul:

    stp x29, x30, [sp, -32]!
    str x23, [sp, -16]!
    str x22, [sp, -16]!
    str x21, [sp, -16]!	//sum
    str x20, [sp, -16]!	//original


    cmp x1, #0	//check if either are zero
    beq zero

    cmp x2, #0	//..
    beq zero

    mov x23, x1	//copy iterations to x23

    mov x20, x0	//copy sum to x20

    mov x22, #0	//set negative flag to 0

    cmp x23, #0	//check if iterator is negative
    bge notneg
    mov x22, #1	//set negative flag to 1

    //mov x0, #0	//x23 = 0 - x23
    //mov x1, x23
    //bl intsub
    //mov x23, x0	//..
    mvn x23, x23
    add x23, x23, #1

notneg:
    mov x0, x20
    mov x1, x0	//x0 is stored in x0 and x1

    loop:

    cmp x23, #1	//check if done
    beq end		//jump to end

    bl intadd

    mov x21, x0	//subtract one from iterator
    mov x20, x1
    mov x0, x23
    mov x1, #1
    bl intsub
    mov x23, x0
    mov x0, x21
    mov x1, x20

    b loop

zero:		//if zero, return 0
    mov x0, #0

    end:

    cmp x22, #0
    beq skipneg

    mov x1, x0	//x0 = -x0
    mov x0, #0
    bl intsub

skipneg:
    ldr x20, [sp], 16
    ldr x21, [sp], 16
    ldr x22, [sp], 16
    ldr x23, [sp], 16

    ldp x29, x30, [sp], 32
    ret
