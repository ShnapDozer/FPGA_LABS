#include <fstream>
#include <iostream>
#include <cstring>
#include <string>
#include <algorithm>

int main() {
    int n;
    std::cin >> n;

    if (n == 0) {
        std::cout << n;
    }
    else if (n < 4) {
        std::cout << 1;
    }
    else {
        int a = 1;
        int b = 1;
        int tmp = 0;
        for (int i = 3; i < n; ++i) {
            tmp = b;
            b = a + b;
            a = tmp;
        }

        std::cout << b;
    }
}

