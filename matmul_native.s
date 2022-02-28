////////////////////////////////////////////////////////////////////////////////
// You're implementing the following function in ARM Assembly
//! C = A * B
//! @param C          result matrix
//! @param A          matrix A 
//! @param B          matrix B
//! @param hA         height of matrix A
//! @param wA         width of matrix A, height of matrix B
//! @param wB         width of matrix B
//
//  Note that while A, B, and C represent two-dimensional matrices,
//  they have all been allocated linearly. This means that the elements
//  in each row are sequential in memory, and that the first element
//  of the second row immedialely follows the last element in the first
//  row, etc. 
//
//void matmul(int* C, const int* A, const int* B, unsigned int hA, 
//    unsigned int wA, unsigned int wB)
//{
//  for (unsigned int i = 0; i < hA; ++i)
//    for (unsigned int j = 0; j < wB; ++j) {
//      int sum = 0;
//      for (unsigned int k = 0; k < wA; ++k) {
//        sum += A[i * wA + k] * B[k * wB + j];
//      }
//      C[i * wB + j] = sum;
//    }
//}
////////////////////////////////////////////////////////////////////////////////

	.arch armv8-a
	.global matmul


//Registers x9 to x15 are callee save
//hA =
//x19 is C
//x20 is A
//x21 is B
//x22 is hA
//x23 is wA
//x24 is wB

//x25 is i
//x26 is j
//x27 is k
//x28 is sum


matmul:
    stp x29, x30, [sp, -32]!
    str x19, [sp, -16]!
    str x20, [sp, -16]!
    str x21, [sp, -16]!
    str x22, [sp, -16]!
    str x23, [sp, -16]!
    str x24, [sp, -16]!

    str x25, [sp, -16]!
    str x26, [sp, -16]!
    str x27, [sp, -16]!
    str x28, [sp, -16]!

    mov x19, x0
    mov x20, x1
    mov x21, x2
    mov x22, x3
    mov x23, x4
    mov x24, x5

    mov x25, #0
    mov x26, #0
    mov x27, #0
    mov x28, #0

for_i:

    cmp x25, x22
    bge break

    for_j:
        cmp x26, x24
        bge break_j

        mov x28, #0


        for_k:
            cmp x27, x23
            bge break_k


            mul x0, x25, x23
            add x0, x0, x27
            mov x9, #4
            mul x0, x0, x9
            add x0, x0, x20

            ldr x11, [x0]

            mul x0, x27, x24
            add x0, x0, x26
            mov x9, #4
            mul x0, x0, x9
            add x0, x0, x21

            ldr x0, [x0]

            mul x0, x0, x11


            add x28, x28, x0

            add x27, x27, #1
            b for_k
        break_k:
        mov x27, #0

        mul x0, x25, x24
        add x0, x0, x26
        mov x9, #4
        mul x0, x0, x9
        add x0, x0, x19
        str x28, [x0]

        add x26, x26, #1
        b for_j

    break_j:
    mov x26, #0

    add x25, x25, #1
    b for_i
break:

    ldr x28, [sp], 16
    ldr x27, [sp], 16
    ldr x26, [sp], 16
    ldr x25, [sp], 16
    ldr x24, [sp], 16
    ldr x23, [sp], 16
    ldr x22, [sp], 16
    ldr x21, [sp], 16
    ldr x20, [sp], 16
    ldr x19, [sp], 16

    ldp x29, x30, [sp], 32
    ret


debug: .asciz "%d\n"
