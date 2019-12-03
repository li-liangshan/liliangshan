# encoding=utf-8

# import tkinter as tk

# root = tk.Tk()

# root.title("FishC Demo")

# label = tk.Label(root, text="我的第二个窗口程序")
# label.pack()

# root.mainloop()

import tkinter
from tkinter.constants import *
tk = tkinter.Tk()
frame = tkinter.Frame(tk, relief=RIDGE, borderwidth=2)
frame.pack(fill=BOTH,expand=1)
label = tkinter.Label(frame, text="Hello, World")
label.pack(fill=X, expand=1)
button = tkinter.Button(frame,text="Exit",command=tk.destroy)
button.pack(side=BOTTOM)
tk.mainloop()
