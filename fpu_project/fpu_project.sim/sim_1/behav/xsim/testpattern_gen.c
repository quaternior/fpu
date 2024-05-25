#define exp_bits  8                         // # of exponent bits
#define frac_bits 23                        // # of fraction bits

#include <stdio.h>
int main(){
    float x, y, z;
    int x_bit, y_bit;
    FILE *fp;

    fp = fopen("pattern.txt", "w");

    x = 0;
    y = 0;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    x = -240;
    y = -120;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    x = 2.0078125;
    y = 4.015625;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    x_bit = 0xff << frac_bits;
    x = *((float*)&x_bit);
    y = *((float*)&x_bit);
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //5 : inf * -inf = -inf
    x_bit = 0xff << frac_bits;
    y_bit = 0x1ff << frac_bits;
    x = *((float*)&x_bit);
    y = *((float*)&y_bit);
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //6 : inf * 0 = NaN
    x_bit = 0xff << frac_bits;
    x = *((float*)&x_bit);
    y = 0;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //7 : Multiply two positive numbers.
    x = 0.675;
    y = 2.0;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //8 : Multiply two negative numbers.
    x = -9.24;
    y = -3.9e-2;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //9 : Multiply two numbers of different signs.
    x = 8.31;
    y = -9.25;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //10 : Multiply zero.
    x = 3.235;
    y = 0.0;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //11 : Multiply two large numbers.
    x = 1.38e21;
    y = 3.2e18;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //12 : Multiply two small numbers.
    x = -8.3e-24;
    y = 1.3e-18;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    //13 : Multiply two smaller numbers.
    x = 1.44e-31;
    y = 5.2e-22;
    fprintf(fp, "%x %x\n", *((int*)&x), *((int*)&y));

    return 0;
}