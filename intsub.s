    // intsub function in this file

    .arch armv8-a
    .global intsub

intsub:
stp x29, x30, [sp, -32]!

str x20, [sp, -16]!		//save reg

mov x20, x0			//store x0 in x20

mvn x0, x1			//twos complement x1
mov x1, #1
bl intadd			//..

mov x1, x20			//mov x20 back to x1
bl intadd 			//add together and return


ldr x20, [sp], 16

ldp x29, x30, [sp], 32
ret
