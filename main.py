# -*- coding: utf-8 -*-
"""
Created on Sat Mar 05 17:02:40 2016

@author: Chen
"""
import pandas as pd
import numpy as np
from frequent_sets_generation import *
# 读入数据
data = pd.read_csv('data.txt', header=None)
# 参数初始化
s = 0.01 #最小支持度
maxlen = 10 #最大频繁集长度
# 得到频繁集
frequent_item = gen_frequent(data, s, maxlen)

