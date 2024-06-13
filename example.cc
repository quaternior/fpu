#include <cfenv>
#include <cmath>
#include <cstdio>

int main() {
    std::fesetround(FE_DOWNWARD); // 음의 무한대로 반올림 설정
    double d = 3.141592653589793;
    int f = (int)(d);
    std::printf("FE_DOWNWARD: %d\n", f);

    std::fesetround(FE_UPWARD); // 양의 무한대로 반올림 설정
    f = (int)(d);
    std::printf("FE_UPWARD: %d\n", f);
    
    std::fesetround(FE_TONEAREST); // 가장 가까운 값으로 반올림 설정
    f = (int)(d);
    std::printf("FE_TONEAREST: %d\n", f);
    
    std::fesetround(FE_TOWARDZERO); // 0으로 반올림 설정
    f = (int)(d);
    std::printf("FE_TOWARDZERO: %d\n", f);

    return 0;
}
