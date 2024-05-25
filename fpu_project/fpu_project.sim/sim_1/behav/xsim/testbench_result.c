#include <stdio.h>
int main(){
    float x, y, z;
    unsigned int x_bit, y_bit;
    int r;
    int i=1;
    FILE *fp;
    fp = fopen("pattern.txt", "r");
    while(1){
        r = fscanf("%x %x", &x_bit, &y_bit);
        if(r==1)
            break;
        z = *((float*)&x_bit) * *(float*)&y_bit);
        printf("%d : %x %x %x", i, x_bit, y_bit, ((int*)&z));
    }

    return 0;
}