# -*- coding: utf-8 -*-
"""
Created on Sat Mar 05 17:03:25 2016

@author: Chen
"""
import numpy as np
import pandas as pd
from itertools import combinations

def union_dict(*objs):
    _keys = set(sum([obj.keys() for obj in objs], []))
    _total = {}
    for key in _keys:
        _total[key] = sum([obj.get(key, 0) for obj in objs])
    return _total

def merge_dict(objs):
    dic = {}
    for obj in objs:
        dic_temp = obj
        dic = union_dict(dic, dic_temp)
    return dic

def check(combine, C0, k):
    for c in combinations(combine, k):
        if c not in C0:
            return False
    return True

def count_support(trans):
    H = {}
    index = trans.index
    for t in index:
        H_temp = dict(trans.ix[t].value_counts())
        H = union_dict(H, H_temp)
    return H

def apriori_gen(L):
    C = []
    if L == []:
        return C
    k = len(L[0])
    for i in range(len(L) - 1):
        for j in range(i + 1, len(L)):
            s1 = set(L[i])
            s2 = set(L[j])
            if len(s1.intersection(s2)) == k - 1:
                s3_temp = s1.union(s2)
                if check(s3_temp, L, k):
                    s3 = tuple(np.sort(list(s3_temp)))
                    C.append(s3)    
    C = list(set(C))
    C.sort()    
    return C

def gen_candidate(H, C0):
    C = []
    if C0 == []:
        return C
    for c in C0:
       if c in H.keys():
           C.append(c)
    return C

def purify(row, minsup, H0):
    H = {} 
    s  = np.floor(row*minsup)
    for k in H0.keys():
        if H0[k] < s:
            del H0[k]
    H = H0
    return H

def gen_insert(trans, C):
    ct = []
    for c in C:
        _c = list(c)
        _c.sort()
        if len(_c) == 2:
            if _c[0] in trans and _c[1] in trans:
                ct.append(c)
        else:    
            c_0 = _c[:-2]
            c_1 = _c[:-2]           
            c1 = _c[-1]
            c2 = _c[-2]
            c_0.append(c1)
            c_1.append(c2)
            if tuple(c_0) in trans and tuple(c_1) in trans:
                ct.append(c)    
            ct.sort()
    return ct  

def gen_frequent(data, s, maxlen):

    H = {}
    L = {}
    C = {}
    D = {}

    row = data.shape[0]

    H[1] = count_support(data)
    H[1] = purify(row, s, H[1])
    L[1] = H[1].keys()
    C[1] = L[1]
    D[1] = {}
    
    index = data.index    

    for v in index:
        data_v = list(data.ix[v])
        data_v.sort()
        D[1][v] = data_v

    for k in range(2, maxlen+1):

        H[k] = {}
        L[k] = []
        C[k] = []
        D[k] = {}
        
        if k==2:
            C[k] = list(combinations(L[1],2))            
        else:
            C[k] = apriori_gen(L[k-1])      
        
        for t in D[k-1].keys():
            ct = gen_insert(D[k-1][t], C[k])
            for c in ct:
                H[k].setdefault(c,0)
                H[k][c] += 1                  
            if ct != []:
                D[k][t] = ct
            
        H[k] = purify(row, s, H[k])  
        L[k] = H[k].keys()

    return H

def output(frequent_item, path):
    frequent_m = {}
    for i in frequent_item.keys():
        frequent_m[i] = np.zeros((len(frequent_item[i].keys()), i + 1))
        for idx, j in enumerate(frequent_item[i].keys()):
            frequent_m[i][idx, :i] = np.array(j)
            frequent_m[i][idx, -1] = frequent_item[i][j]
    num = 0 
    for i in frequent_item.keys():
        if frequent_item[i] != {}:
            num += 1
    for i in range(num):
        ma = frequent_m[i+1]
        df = pd.DataFrame(ma)        
        df.to_csv(path + 'matrix%s.csv' %str(i+1)) 
    return num
    
    
