# encoding=utf-8

a = '520'
result = isinstance(a, str)
print("result: " + str(result))

result = isinstance(4, int)
print("result: " + str(result))

result = isinstance(4.5, float)
print("result: " + str(result))

assert 3 < 4

for i in range(1, 20, 2):
    print("current:" + str(i))

numbers = [1, 2, 3, 4, 5, 6, 7]
numbers.append(8)
print(numbers)
numbers.extend([12, 13])
numbers[0] = 34
print(numbers)
del numbers[3]
print(numbers)


# format
print("{0} love {1}.{2}".format("I", "kotlin", "python"))
print("{a} love {b}.{c}".format(a="I", b="kotlin", c="python"))

# filter
temp = filter(None, [1, 0, True, False])
print(temp)

temp = filter(lambda x: x % 2, [1, 2, 3, 4, 5, 6, 7, 8, 9])
print(temp)

# map
print(map(lambda x: x % 2, [1, 2, 3, 4, 5, 6, 7, 8, 9]))

# 字典
# 1.创建字典
empty = {}
dict1 = dict(F=79, i=105)
print(dict1)

print(dict1.fromkeys(("a", "b", "c"), 5))
