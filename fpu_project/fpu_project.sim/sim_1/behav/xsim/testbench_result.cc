#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>

using namespace std;
int main(){
    float* a, *b, *y, *ysim;
    unsigned int a_bit, b_bit, y_bit, ysim_bit;
    char op;
    bool is_correct, testmode;
    int Sel;
    int i=1;
    ifstream fp;
    

    a = (float*)&a_bit;
    b = (float*)&b_bit;
    y = (float*)&y_bit;
    y = (float*)&ysim_bit;

    is_correct = true;
    testmode = false;
    fp.open("pattern.txt");

    std::string line;
    while (std::getline(fp, line)) {
        std::istringstream iss(line);
        while (testmode ? (iss >> std::hex >> a_bit >> b_bit >> Sel >> ysim_bit)
                        : (iss >> std::hex >> a_bit >> b_bit >> Sel)) {
            //Set denormalized number to 0
            if ((a_bit >> 23) & 0x7f == 0)
                a_bit = a_bit & (0x7fffff + (1 << 31));
            if ((b_bit >> 23) & 0x7f == 0)
                b_bit = b_bit & (0x7fffff + (1 << 31));
            //Set operator
            Sel = 3;
            // switch (Sel)
            // {
            //     case 0:
            //         op = '+';
            //         *y = (*a) + (*b);
            //         break;
            //     case 1:
            //         op = '-';
            //         *y = (*a) - (*b);
            //         break;
            //     case 2:
            //         op = '*';
            //         *y = (*a) * (*b);
            //         break;
            //     case 3:
            //         op = '/';
            //         *y = (*a) / (*b);
            //         break;
            //     default:
            //         return 1;
            // }
            //Print all
            std::cout << std::setw(8) << i++
                    << std::setw(12) << std::hex << std::showbase << a_bit
                    << std::setw(12) << std::hex << std::showbase << b_bit
                    << std::setw(12) << std::hex << std::showbase << y_bit
                    << std::setw(12) << std::dec << *a
                    << " " << op << " "
                    << std::setw(12) << *b
                    << " = "
                    << std::setw(12) << *y;
                    if(testmode){
                        std::cout << "(Simulation)"
                        << std::setw(12) << *ysim
                        << std::setw(8) << std::boolalpha << is_correct << std::endl;
                    }
        }
    }


}