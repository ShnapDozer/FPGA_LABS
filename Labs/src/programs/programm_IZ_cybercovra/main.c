// Вывести n-ый член последовательности Фибоначчи Fn. n = sw_i. Вывести результат в out_o.
// Пример: sw_i = 0...0100.
// Результат вычислений: out_o = 0...010.

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

    return 0;
}
    



