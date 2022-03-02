# cpe315-matmul
## Tyler Bovenzi: tylerbovenzi

## Shae Li: wwo233

## John Kroska: jkroska

### To build:
```shell
make clean; make
```
### To run:
```shell
perf stat ./mm > p.out
```
### To test:
```shell
diff p.out outputs/N.out
```
Note that N above is one of:
* 16
* 64
* 256
* 1024

### To modify the size:
1. edit the matmul.h file
2. edit the line with: 
```C
#define MATRIX_SIZE
```
3. Save the file
4. Rebuild

### To test with ARM MUL:
1. edit the Makefile
2. change matmul.s to matmul_mul.s
4. Rebuild
