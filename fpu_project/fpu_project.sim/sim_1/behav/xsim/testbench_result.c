#include <stdio.h>
int main(){
    float* x, *y, *z;
    unsigned int x_bit, y_bit, z_bit;
    char op, is_correct;
    int r;
    int i=1;
    FILE *fp;
    x = &x_bit;
    y = &y_bit;
    z = &z_bit;

    // Revised soon!
    op = '*';
    is_correct = 'O';
    fp = fopen("pattern.txt", "r");
    while(1){
        r = fscanf(fp, "%x %x", &x_bit, &y_bit);
        if(r==-1)
            break;
        // Set zero for denormalized number
        if((x_bit>>23) & 0x7f == 0)
            x_bit = x_bit & (0x7fffff + (1 << 31));
        if((x_bit>>23) & 0x7f == 0)
            y_bit = y_bit = x_bit & (0x7fffff + (1 << 31));
        *z = (*x) * (*y);
        printf("%2d : %8x %8x %8x  %Lf %c %Lf = %Lf / %c\n", i++, x_bit, y_bit, z_bit, *x, op, *y, *z, is_correct);
    }
    fclose(fp);

    return 0;
}