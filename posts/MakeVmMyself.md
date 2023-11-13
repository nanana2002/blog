## 从零开始写一个自己的虚拟机

### 第一步 理论学习与验证
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
