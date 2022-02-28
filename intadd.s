//   Replace this file with your own implementation

    .arch armv8-a
    .global intadd

intadd:

    stp x29, x30, [sp, -32]!	//store registers
    str x21, [sp, -16]!
    str x20, [sp, -16]!

    mov x20, x1

loop:

    eor x21, x0, x1		//XOR addends

    and x1, x0, x1		//and and shift for carry
    lsl x1, x1, #1

    mov x0, x21

    cmp x1, #0			//if carry is 0, break
    bne loop

    mov x1, x20			//dont overwrite x1

    ldr x20, [sp], 16
    ldr x21, [sp], 16

    ldp x29, x30, [sp], 32
    ret
