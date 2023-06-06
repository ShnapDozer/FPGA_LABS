
#include <cstdint>

#define PERIPHERAL_SWITCHES_BASE_ADDR       0x01000000

#define PERIPHERAL_LEDS_BASE_ADDR           0x02000000
#define PERIPHERAL_LEDS_WRITE_OFFSET        0x00000000
#define PERIPHERAL_LEDS_BLINKMODE_OFFSET    0x00000004
#define PERIPHERAL_LEDS_RESET_OFFSET        0x00000024

// Вывести n-ый член последовательности Фибоначчи Fn. n = sw_i. Вывести результат в out_o.
// Пример: sw_i = 0...0100.
// Результат вычислений: out_o = 0...010.

uint32_t fibanaci(uint32_t n) {
    if (n == 0) {
        return 0;
    } else if (n < 4) {
        return 1;
    } 

    int a = 1;
    int b = 1;
    int tmp = 0;
    for (int i = 3; i < n; ++i) {
        tmp = b;
        b = a + b;
        a = tmp;
    }
    return b;
}

int main()
{
    uint32_t* ledsWrite = reinterpret_cast<uint32_t*>(PERIPHERAL_LEDS_BASE_ADDR + PERIPHERAL_LEDS_WRITE_OFFSET);
    uint32_t* ledsReset = reinterpret_cast<uint32_t*>(PERIPHERAL_LEDS_BASE_ADDR + PERIPHERAL_LEDS_RESET_OFFSET);
    uint32_t* ledsBlinkMode = reinterpret_cast<uint32_t*>(PERIPHERAL_LEDS_BASE_ADDR + PERIPHERAL_LEDS_BLINKMODE_OFFSET);
    uint32_t* switches = reinterpret_cast<uint32_t*>(PERIPHERAL_SWITCHES_BASE_ADDR);

    uint32_t curSwitches;

    *ledsReset = 1;
    *ledsReset = 0;

    *ledsBlinkMode = 0;

    curSwitches = 10;
    *ledsWrite = fibanaci(curSwitches);

    while(1) {
        *ledsWrite = fibanaci(curSwitches);               
        if(*switches != curSwitches) {
            curSwitches = *switches;
            *ledsWrite = fibanaci(curSwitches);
        }
    }
}