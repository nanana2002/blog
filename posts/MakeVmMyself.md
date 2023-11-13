## 从零开始写一个自己的虚拟机

### 第一步 理论学习与验证

这个虚拟机只能执行一个非常简单的操作——将两个数相加。为了保持简单，我忽略了一些真实虚拟机应具备的复杂特性，比如真实的指令集、内存管理等。

VM 结构表示虚拟机的状态。它只有一个字段：一个整数寄存器。

vm_init 函数初始化虚拟机的状态。它将寄存器设置为0。

vm_add 函数是虚拟机能够执行的唯一指令。它将一个值加到寄存器上。

vm_print 函数打印虚拟机的状态。它显示寄存器的当前值。

main 函数创建并初始化虚拟机，执行一些指令，然后打印虚拟机的状态。

这个例子展示了虚拟机的基本思想：虚拟机维护一些状态（在这个例子中，就是一个寄存器），并可以执行一些改变这些状态的指令。

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

### 
