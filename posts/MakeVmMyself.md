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
    vm->memory = malloc(MEM_SIZE);  // 为内存区域分配空间
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

这个新版本的虚拟机有四个寄存器（regA，regB，regC和regD）和一个1024字节的内存区域。vm_init函数初始化寄存器并为内存区域分配空间，vm_free函数释放分配的内存。

- vm_run函数执行一些简单的指令：它将5和3加在一起，并将结果存储在regC和内存的第一个字节中。
- vm_print函数打印寄存器的值和内存的第一个字节的值。

仍然很弱智，但是现在它有了更多的寄存器和一些内存。

