# encoding=utf-8
try:
    with open("/Users/liliangshan/Desktop/产量绩效工资_20191107-1353.xlsx", mode='r') as file:
        result = file.read()
        print(result)
    raise ZeroDivisionError("没有零值异常，这是我自己抛出的异常！！！")
except Exception as reason:
    print(reason)
except (OSError, TypeError):
    print("os error or type error!!")
except ZeroDivisionError as reason:
    print(str(reason))
except:
    print("这里是捕获所有异常")
finally:
    print("game over!!!!")
