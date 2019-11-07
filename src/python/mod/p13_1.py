# encoding=utf-8


def c2f(cel):
  fah = cel * 1.8 + 32
  return fah


def f2c(fah):
  cel = (fah - 32) / 1.8
  return cel
