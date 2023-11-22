# 一个可能简单也可能复杂的迷宫小游戏

这是一时冲动去写的一个玩具项目。

它仍在开发初期，并且我也不知道接下来它会被写成什么样。

它的Github链接：https://github.com/BH3GEI/MazeGame

### 第一步，写一个最简单的测试

```python

class Room(object):

    def __init__(self, name, description, end_game=False):
        self.name = name
        self.description = description
        self.end_game = end_game
        self.paths = {}

    def go(self, direction):
        return self.paths.get(direction, None)

    def add_paths(self, paths):
        self.paths.update(paths)

start = Room("Start", "你在一个暗淡的房间里，有三个门分别在你的前方、左方和右方。")
gold_room = Room("GoldRoom", "这个房间里满是黄金，你赢了！", end_game=True)
death = Room("Death", "你走进一个空荡荡的房间，突然门在你身后关上，你被困在了里面。游戏结束。", end_game=True)
maze_room = Room("Maze", "你进入了一个迷宫，快去找出口吧。")
hidden_room = Room("HiddenRoom", "你找到了一个隐藏的房间，里面有一个通往金室的秘密通道。")

start.add_paths({'前方': death, '左方': maze_room, '右方': death})
gold_room.add_paths({'后方': start})
maze_room.add_paths({'左方': hidden_room, '右方': start})
hidden_room.add_paths({'前方': gold_room})

map = {
    "Start": start,
    "GoldRoom": gold_room,
    "Death": death,
    "Maze": maze_room,
    "HiddenRoom": hidden_room,
}

location = "Start"

while True:
    room = map[location]

    print("\n" + "-" * 10)
    print(room.description)

    if room.end_game:
        break

    action = input("> ")

    if action in room.paths.keys():
        location = room.go(action).name
    else:
        print("你不能那么做。")
```

### 第二步 尝试把场景三维化

使用现成框架的事情我以前也做过。于是我就想，要不然实现一个自己的图形引擎？

Games101基因动了，笑死。

当然了，性能在我这里并不是第一优先，一切以赶紧实现一个简单的demo为最优先。下面先写一些废话和伪代码。

在一个Linux环境中，如Ubuntu，直接进行图形渲染最基本的方式是使用framebuffer。Framebuffer是一个在内核级别提供的接口，它允许直接向显示设备写入像素数据。


下面贴一段丑陋的伪代码，我想先实现一个旋转的立方体。

```cpp

#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/fb.h>
#include <sys/mmap.h>
#include <math.h>
#include <unistd.h>

// 3D向量
struct Vec3 {
    float x, y, z;
};

// 3D旋转
Vec3 rotate(Vec3 v, float angleX, float angleY, float angleZ) {
    // 实现3D旋转的矩阵运算
}

int main() {
    // 打开framebuffer
    int fbfd = open("/dev/fb0", O_RDWR);
    struct fb_var_screeninfo vinfo;
    ioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo);

    // 映射framebuffer到内存
    long screensize = vinfo.xres * vinfo.yres * vinfo.bits_per_pixel / 8;
    char* fbp = mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0);

    // 立方体的顶点
    Vec3 cube[8] = {
        {-1, -1, -1},
        {1, -1, -1},
        {1, 1, -1},
        {-1, 1, -1},
        {-1, -1, 1},
        {1, -1, 1},
        {1, 1, 1},
        {-1, 1, 1},
    };

    float angle = 0;
    while(1) {
        // 清除屏幕
        memset(fbp, 0, screensize);

        // 计算旋转的角度
        angle += 0.01;
        if(angle > 2 * M_PI) angle -= 2 * M_PI;

        // 绘制立方体的每条边
        for(int i = 0; i < 8; i++) {
            for(int j = i + 1; j < 8; j++) {
                // 如果顶点i和j之间有一条边
                if(abs(i - j) == 1 || abs(i - j) == 2 || abs(i - j) == 4) {
                    // 计算旋转后的顶点位置
                    Vec3 vi = rotate(cube[i], angle, angle, angle);
                    Vec3 vj = rotate(cube[j], angle, angle, angle);

                    // 线段的光栅化
                    // 查找Bresenham算法或者DDA算法?
                }
            }
        }

        // 等待下一帧
        usleep(10000);
    }

    // 释放资源
    munmap(fbp, screensize);
    close(fbfd);

    return 0;
}

```

接下来具体的实现：

