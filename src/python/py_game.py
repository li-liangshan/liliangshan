# encoding=utf-8

"""---第一个小游戏---"""

temp = input("不妨猜一下小甲鱼现在心里想的是哪一个数字：")
guess = int(temp)

if guess == 8:
    print("小甲鱼现在是在想蛔虫吗？")
    print("哼，猜中也没有奖励！")
else:
	print("猜错了，小甲鱼现在心里想的是8！")

print("游戏结束，不玩了！！！")
