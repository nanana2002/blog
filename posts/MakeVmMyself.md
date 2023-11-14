## 从零开始写一个自己的虚拟机

### 第一步 理论学习与验证
#### First Try

```cpp
#include <stdio.h>

// 虚拟机只有一个寄存器
typedef struct {
    int reg;
} VM;

void vm_init(VM* vm) {
    vm->reg = 0;
}

// 唯一指令：加法
void vm_add(VM* vm, int value) {
    vm->reg += value;
}

// 打印状态
void vm_print(VM* vm) {
    printf("Register: %d\n", vm->reg);
}

int main() {
    // 创建并初始化
    VM vm;
    vm_init(&vm);

    // 执行
    vm_add(&vm, 5);
    vm_add(&vm, 3);

    // 打印状态
    vm_print(&vm);

    return 0;
}
```

这个虚拟机只能执行一个非常简单的操作——将两个数相加。为了保持简单，我忽略了一些真实虚拟机应具备的复杂特性，比如真实的指令集、内存管理等。

- VM 结构表示虚拟机的状态。它只有一个字段：一个整数寄存器。
- vm_init 函数初始化虚拟机的状态。它将寄存器设置为0。
- vm_add 函数是虚拟机能够执行的唯一指令。它将一个值加到寄存器上。
- vm_print 函数打印虚拟机的状态。它显示寄存器的当前值。
- main 函数创建并初始化虚拟机，执行一些指令，然后打印虚拟机的状态。

这个例子展示了虚拟机的基本思想：虚拟机维护一些状态（一个寄存器），并可以执行一些改变这些状态的指令。

#### 进一步理解

接下来做些什么？

- 增加更多的寄存器？
- 引入内存？
- 实现更复杂的指令？
- 引入指令编码？
- 添加设备模拟？
- 模拟一个真实的CPU架构？？

太深了我也理解不了，那就先增加更多的寄存器，引入内存来试试看
```cpp

#include <stdio.h>
#include <stdlib.h>

#define MEM_SIZE 1024  // 定义内存大小为1024字节

// 四个寄存器、一个内存区域
typedef struct {
    int regA;
    int regB;
    int regC;
    int regD;
    unsigned char* memory;  // 指向内存区域的指针
} VM;

// 初始化
void vm_init(VM* vm) {
    vm->regA = 0;
    vm->regB = 0;
    vm->regC = 0;
    vm->regD = 0;
    vm->memory = static_cast<unsigned char*>(malloc(MEM_SIZE));  // 为内存区域分配空间
    if (vm->memory == NULL) {
        fprintf(stderr, "Failed to allocate memory\n");
        exit(1);
    }
}

// 清理
void vm_free(VM* vm) {
    free(vm->memory);  // 释放内存区域
}

// 指令
void vm_run(VM* vm) {
    vm->regA = 5;
    vm->regB = 3;
    vm->regC = vm->regA + vm->regB;
    vm->memory[0] = vm->regC;  // 存储结果到内存
}

// 打印状态
void vm_print(VM* vm) {
    printf("Register A: %d\n", vm->regA);
    printf("Register B: %d\n", vm->regB);
    printf("Register C: %d\n", vm->regC);
    printf("Register D: %d\n", vm->regD);
    printf("Memory[0]: %d\n", vm->memory[0]);
}

int main() {
    // 创建并初始化
    VM vm;
    vm_init(&vm);

    // 执行指令
    vm_run(&vm);

    // 打印状态
    vm_print(&vm);

    // 清理
    vm_free(&vm);

    return 0;
}

```

现在有四个寄存器（regA，regB，regC和regD）和一个1024字节的内存区域。vm_init函数初始化寄存器并为内存区域分配空间，vm_free函数释放分配的内存。

- vm_run函数执行一些简单的指令：它将5和3加在一起，并将结果存储在regC和内存的第一个字节中。
- vm_print函数打印寄存器的值和内存的第一个字节的值。

仍然很弱智，但是现在它有了更多的寄存器和一些内存。

#### 进行下一步的尝试

下一步或许应该添加一些更复杂的指令并引入指令编码？

先写一下试试看。

首先，定义一些操作码（opcode）来表示指令。可以使用枚举类型来定义操作码。比如：

```cpp
typedef enum {
    OP_HALT,  // 停止执行
    OP_LOAD,  // 加载值到寄存器
    OP_ADD,   // 添加两个寄存器的值
    OP_STORE, // 将寄存器的值存储到内存
    // 更多的指令...
} Opcode;
```

然后表示指令。一个简单的方法是使用一个结构体，其中包含操作码和一些操作数：

```cpp
typedef struct {
    Opcode opcode;
    int reg1;
    int reg2;
    int reg3;
    int value;  // 对于LOAD指令，这是要加载到寄存器的值；对于STORE指令，这是内存的地址
} Instruction;
```

接下来修改`vm_run`函数，让它执行一个指令数组，而不是硬编码的指令：

```c
void vm_run(VM* vm, Instruction* instructions, int num_instructions) {
    for (int i = 0; i < num_instructions; i++) {
        Instruction* instr = &instructions[i];
        switch (instr->opcode) {
            case OP_HALT:
                return;
            case OP_LOAD:
                vm->regA = instr->value;
                break;
            case OP_ADD:
                vm->regC = vm->regA + vm->regB;
                break;
            case OP_STORE:
                vm->memory[instr->value] = vm->regC;
                break;
            // 更多的指令...
        }
    }
}
```

然后在`main`函数中创建指令并运行：

```c
int main() {
    // 创建并初始化
    VM vm;
    vm_init(&vm);

    // 创建指令
    Instruction instructions[] = {
        {OP_LOAD, .value = 5},
        {OP_LOAD, .value = 3},
        {OP_ADD},
        {OP_STORE, .value = 0},
        {OP_HALT}
    };

    // 执行指令
    vm_run(&vm, instructions, sizeof(instructions) / sizeof(Instruction));

    // 打印状态
    vm_print(&vm);

    // 清理
    vm_free(&vm);

    return 0;
}
```

综合起来就是下面这样：

```cpp

#include <stdio.h>
#include <stdlib.h>

typedef enum {
    OP_HALT,
    OP_LOAD,
    OP_ADD,
    OP_STORE,
} Opcode;

typedef struct {
    Opcode opcode;
    int reg1;
    int reg2;
    int reg3;
    int value;
} Instruction;

typedef struct {
    int regA;
    int regB;
    int regC;
    int* memory;
    int memory_size;
} VM;

void vm_init(VM* vm, int memory_size) {
    vm->regA = 0;
    vm->regB = 0;
    vm->regC = 0;
    vm->memory = (int*)calloc(memory_size, sizeof(int));
    vm->memory_size = memory_size;
}

void vm_free(VM* vm) {
    free(vm->memory);
    vm->memory = NULL;
    vm->memory_size = 0;
}

void vm_run(VM* vm, Instruction* instructions, int num_instructions) {
    for (int i = 0; i < num_instructions; i++) {
        Instruction* instr = &instructions[i];
        switch (instr->opcode) {
            case OP_HALT:
                return;
            case OP_LOAD:
                vm->regA = instr->value;
                break;
            case OP_ADD:
                vm->regB = vm->regA;
                vm->regA = instr->value;
                vm->regC = vm->regA + vm->regB;
                break;
            case OP_STORE:
                vm->memory[instr->value] = vm->regC;
                break;
        }
    }
}

void vm_print(VM* vm) {
    printf("regA: %d\n", vm->regA);
    printf("regB: %d\n", vm->regB);
    printf("regC: %d\n", vm->regC);
    printf("memory[0]: %d\n", vm->memory[0]);
}

int main() {
    VM vm;
    vm_init(&vm, 10);

    Instruction instructions[] = {
        {OP_LOAD, .value = 5},
        {OP_LOAD, .value = 3},
        {OP_ADD},
        {OP_STORE, .value = 0},
        {OP_HALT}
    };

    vm_run(&vm, instructions, sizeof(instructions) / sizeof(Instruction));
    vm_print(&vm);
    vm_free(&vm);

    return 0;
}

```

### 第二步 尝试创建CHIP-8虚拟机

#### 引入

好了好了，理论差不多了，小孩子过家家的代码实在丢人，开始干正事吧。

CHIP-8指令集只有35条指令，很多小白都用它来上手，那咱也写一个。

开整！

#### CHIP-8的基本特性

```
   ________    _             ____ 
  / ____/ /_  (_)___        ( __ )
 / /   / __ \/ / __ \______/ __  |
/ /___/ / / / / /_/ /_____/ /_/ / 
\____/_/ /_/_/ .___/      \____/  
            /_/                   
```

- 内存：4KB，从0x000到0xFFF。
- 寄存器：16个8位的数据寄存器，通常被称为V0到VF。其中VF寄存器通常被用作标志寄存器。
- 堆栈：一个堆栈和一个堆栈指针，通常被用于存储返回地址。
- 计时器：两个计时器，一个是延迟计时器，另一个是声音计时器。
- 输入：一个16键的键盘，通常被用于用户输入。
- 显示：一个64x32像素的单色显示。

Chip-8 并不是实际的硬件，它是一种虚拟机（如 Java）。在七八十年代，人们为了对微型计算机（例如Telmac 1800）进行编程而设计了它。它并不使用实际的微处理器操作码，而是一种虚拟语言，并在运行时进行解释。

一些参考资料：

- https://github.com/BH3GEI/build-your-own-x#build-your-own-emulator--virtual-machine
- https://www.jmeiners.com/lc3-vm/#s0:8
- https://github.com/leonmavr/chip-8
- http://www.hobbylabs.org/telmac.htm
- http://www.emulator101.com/introduction-to-chip-8.html
- http://devernay.free.fr/hacks/chip8/C8TECH10.HTM#0.0
- https://github.com/sarbajitsaha/Chip-8-Emulator

#### 初步的设计

应该会包含以下几个文件：

- `main.cpp`：主程序，处理命令行参数，创建和运行CHIP-8实例
- `chip8.h` 和 `chip8.cpp`：定义并实现 CHIP-8 虚拟机的主要功能
    - 其中`chip8.h` 文件定义一个 CHIP-8 类，它包含：
        - 内存、寄存器、栈、计数器等状态。
        - 加载 ROM 到内存的方法。
        - 模拟 CPU 周期的方法，包括获取和解码操作码，执行相应的操作。
        - 实现 CHIP-8 指令集的方法。
- `display.h` 和 `display.cpp`：处理屏幕显示，分辨率64*32，可能得调一个图形库
    - `display.h` 文件定义一个 Display 类，包含：
        - 一个二维数组，表示屏幕的状态。
        - 清除屏幕的方法。
        - 绘制像素的方法。 
- `keyboard.h` 和 `keyboard.cpp`：处理键盘输入。16 键，每个键对应一个十六进制的数字
    - `keyboard.h` 文件定义一个 Keyboard 类，包含：
        - 一个数组，表示键盘的状态。
        - 检查键是否被按下的方法。
        - 等待键被按下的方法。
- `sound.h` 和 `sound.cpp`：处理声音输出。声音计数器不为零时，应播放声音。
    - `sound.h` 文件定义一个 Sound 类，包含：
        - 播放声音的方法。
        - 停止播放声音的方法。

#### 开发过程笔记

首先，我开了个新的项目：https://github.com/BH3GEI/CHIP-8VirtualMachine

另外，我的工作是Make the OS，所以我之后会用别人的rom测试：https://github.com/dmatlack/chip8/tree/master/roms/games

开发过程的所思所想都会记录在这里。


#### 成果演示

### 第三步 尝试实现一个可用的Game Boy虚拟机

