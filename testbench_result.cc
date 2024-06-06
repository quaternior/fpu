#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>

using namespace std;
int main(){
    float *a, *b, *y, *ysim;
    unsigned int a_bit, atmp_bit, b_bit, btmp_bit, y_bit, ysim_bit;
    char op;
    bool is_correct, testmode;
    int Sel;
    int i=1;
    ifstream fp, fp_r;
    
    a = (float*)&atmp_bit;
    b = (float*)&btmp_bit;
    y = (float*)&y_bit;
    ysim = (float*)&ysim_bit;

    is_correct = true;
    testmode = false;
    fp.open("pattern_gb.txt");
    fp_r.open("result.csv");

    std::string line;
    while (std::getline(fp, line)) {
        std::istringstream iss(line);
        while (iss >> std::hex >> a_bit >> b_bit >> Sel) {
            if(testmode){
                string str_buf;
                for(int i=0;i<3;i++){
                    getline(fp_r,str_buf,',');
                }
                ysim_bit = stoi(str_buf); 
            }
            //Storing the temp bits
            atmp_bit = a_bit;
            btmp_bit = b_bit;
            // Set denormalized number to 0
            if (((atmp_bit >> 23) & 0xff) == 0){
                atmp_bit = atmp_bit & (0x0 + (1 << 31));
            }
            if (((btmp_bit >> 23) & 0xff) == 0){
                btmp_bit = btmp_bit & (0x0 + (1 << 31));
            }
            //Set operator
            Sel = 3;
            switch (Sel)
            {
                case 0:
                    op = '+';
                    *y = (*a) + (*b);
                    break;
                case 1:
                    op = '-';
                    *y = (*a) - (*b);
                    break;
                case 2:
                    op = '*';
                    *y = (*a) * (*b);
                    break;
                case 3:
                    op = '/';
                    *y = (*a) / (*b);
                    break;
                default:
                    return 1;
            } 
            if (((y_bit >> 23) & 0xff) == 0){
                y_bit = y_bit & (0x0 + (1 << 31));
            }
            //Print all
            std::cout << std::setw(8) << i++
                    << std::setw(12) << std::hex << std::showbase << a_bit
                    << std::setw(12) << std::hex << std::showbase << b_bit
                    << std::setw(12) << std::hex << std::showbase << y_bit
                    << std::setw(12) << std::dec << (*a)
                    << " " << op << " "
                    << std::setw(13) << (*b)
                    << " = "
                    << std::setw(13) << *y;
                    if(testmode){
                        std::cout << "(Simulation)"
                        << std::setw(12) << std::hex << ysim_bit
                        << std::setw(13) << *ysim
                        << std::setw(8) << std::boolalpha << is_correct;
                    }
                    std::cout << std::endl;
        }
    }
}