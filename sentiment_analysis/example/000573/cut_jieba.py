#encoding=utf-8

import xlrd
import jieba
import sys

test = xlrd.open_workbook('000573.xls')

sh = test.sheet_by_index(0)

f = file('test.txt', 'a')
for i in range(0, sh.nrows):
    word = sh.cell_value(rowx=i, colx=1)
    time=sh.cell_value(rowx=i, colx=5)
    seg_list = jieba.cut(word)
    tmp = (' '.join(seg_list)).encode('utf-8')
    m=tmp.split('\n')
    out_time=time.encode('utf-8')
    for i in m:
        f.write(i)
    f.writelines('&'+time+'\n')
