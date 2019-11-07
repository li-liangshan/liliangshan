# encoding=utf-8


class Turtle:

    color = 'green'
    weight = 10
    legs = 4
    shell = True
    mouth = "大嘴"

    def climb(self):
        print("努力的向前爬！！！")

    def run(self):
        print("在奔跑")

    def eat(self):
        print("在eat")


tt = Turtle()
tt.climb()
tt.run()
tt.eat()

# python 魔方方法： __init__()  --> 构造方法


class Potato:

    __tag = "tag"

    def __init__(self, name):
        self.name = name
        print(self.name)

    def kick(self, name):
        self.name = name
        print(name)

    def now(self):
        print(self.name)


potato = Potato("hello")
potato.kick("what")
potato.now()

print(potato._Potato__tag)


class Parent:

    def hello(self):
        print("running parent hello method")

    def world(self):
        print("this is parent world method!!!")


class Child(Parent):

    def __init__(self, *args, **kwargs):
        # super().__init__()
        print("child __init__")

    def world(self):
        print("this is child world method...")


parent = Parent()
parent.hello()
parent.world()
child = Child()
child.hello()
child.world()


#  多重继承
class Base1:
    def foo1(self):
        print("base1 foo1")


class Base2:
    def foo2(self):
        print("base2 foo2")


class C(Base1, Base2):
    pass


c = C()
c.foo1()
c.foo2()


# __new__(cls[, ...])
# __del__(self)
