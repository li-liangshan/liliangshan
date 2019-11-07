# encoding=utf-8

import random

secret = random.randint(0, 10)

temp = input("不妨猜一下小甲鱼现在心里想的是哪一个数字:")
guess = int(temp)

while guess != secret:
    temp = input("猜错了，重新猜：")
    guess = int(temp)

    if guess == secret:
        print("小甲鱼现在是在想蛔虫吗？")
        print("哼，猜中也没有奖励！")
    else:
        if guess > secret:
            print("猜大了！")
        else:
            print("猜小了！")

print("游戏结束，不玩了！！！")
