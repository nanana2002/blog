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


