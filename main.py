# -*- coding: utf-8 -*-
"""
Created on Sat Mar 05 17:02:40 2016

@author: Chen
"""
import pandas as pd
import numpy as np
from frequent_sets_generation import *

# 读入数据 
filename = 'supermarket'
data = pd.read_csv('data//%s.csv'%filename, header=0)

# 参数初始化 
s = 0.2 #最小支持度
maxlen = 10 #最大频繁集长度

# 得到频繁集
frequent_item = gen_frequent(data, s, maxlen)

# 输出数据
path = 'data//'
num = output(frequent_item, path)
row = data.shape[0]

# 输出数据信息
info = 'name: %s num: %d row: %d'%(filename, num, row)
f = open(path + 'info.txt', 'w+')
f.write(info)
f.close()
