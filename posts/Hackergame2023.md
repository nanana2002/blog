## 这是个人解题时的一些想法，具体的writeup官方已经公布，请参考

比赛官网：https://hack.lug.ustc.edu.cn/

官方题解：https://github.com/USTC-Hackergame/hackergame2023-writeups

### 第一题

![image](https://github.com/BH3GEI/blog/assets/58540850/514b26da-b14a-4780-9183-43cb1765ff4e)

![image](https://github.com/BH3GEI/blog/assets/58540850/884912eb-5c16-4dc7-9a54-92151dcc43cd)

![image](https://github.com/BH3GEI/blog/assets/58540850/1c65bc6c-1937-4f90-a4d4-ef271c87d20e)

similarity的值更改为100即可

### 第二题
![image_2023-10-31_17-00-41](https://github.com/BH3GEI/blog/assets/58540850/13e4fde8-ff7e-4e64-a3a6-1ab4e1bf7507)

1、2问bard

3常识

4、搜索关键字python mypy loop halting problem conference

### 第三题
![image_2023-10-31_17-03-25](https://github.com/BH3GEI/blog/assets/58540850/88cf59ba-0e01-4ec7-8999-efb286ff4818)

![image_2023-10-31_17-03-25 (2)](https://github.com/BH3GEI/blog/assets/58540850/081ddf27-f804-42f9-a400-1938c5a71ca2)

挺地狱的，但是简单，往下拉没用，inspect一下element，直接就有flag

### 第四题

![image](https://github.com/BH3GEI/blog/assets/58540850/7c847839-8568-404f-9362-ee8926904c0d)

![image](https://github.com/BH3GEI/blog/assets/58540850/d05ef336-b91d-4ad5-92c5-a3c55923a109)

![image](https://github.com/BH3GEI/blog/assets/58540850/59a4e173-fc5f-4aea-b5d8-53c271addacf)

### 第五题

![image_2023-10-31_17-06-11](https://github.com/BH3GEI/blog/assets/58540850/5b32e855-eeac-4a70-b498-86b155a12062)

![image_2023-10-31_17-06-11 (2)](https://github.com/BH3GEI/blog/assets/58540850/ece9bf92-6873-4c91-816a-1d674f025124)

直接无视掉ai下的子就行，你想下到哪就往哪post，然后看response即可

### 第六题

图像隐写，没做出来

### 第七题

会把所有的消息都事先发下来，还提供了delete和flag的接口，不要管前端界面，浏览器拿到cookie之后，整个程序挨个给服务器发请求，最后请求flag就行了

### 第八题

SSTV，用robot36解析一下就行

### 第九题

![image](https://github.com/BH3GEI/blog/assets/58540850/355bf566-d333-46f3-b2da-02306679f7b8)

![image](https://github.com/BH3GEI/blog/assets/58540850/6626f004-b45a-4d97-bdfc-51ae92b58888)

只做出第一问

### 第十题

reflog，然后rebase过去

### 第11题

200, 400, 404, 405, 505

第二问是这样

![image](https://github.com/BH3GEI/blog/assets/58540850/7c89cce3-e026-4466-931b-c37241431f94)

### 第12题

![image](https://github.com/BH3GEI/blog/assets/58540850/c1c8c718-6fbc-420b-8c00-38ca447fb2dd)

docker逃逸

### 第13题

第13就是依据flag{}这几个特殊位，调节待抽取的字符的位置，不用自己去加e和辅音，它删掉的和flag无关
```python

#!/usr/bin/python3

# Th siz of th fil may reduc after XZRJification

def check_equals(left, right):
    # check whether left == right or not
    if left != right: exit(1)

def get_cod_dict():
    # prepar th cod dict
    cod_dict = []
    cod_dict += ['nymeh1niwemflcir}echaet_']
    cod_dict += ['a3g7}kidgojernoetlsup?h_']
    cod_dict += ['ulw!_f5soadrhwnrsnstnoeq']#
    cod_dict += ['ct_{l-findiehaai{oveatas']
    cod_dict += ['ty9kxborszst_guyd?!blm-p']

    print(3)
    check_equals(set(len(s) for s in cod_dict), {24})
    print(4)
    return ''.join(cod_dict)

def decrypt_data(input_codes):
    # retriev th decrypted data
    cod_dict = get_cod_dict()
    print(5)
    output_chars = [cod_dict[c] for c in input_codes]
    print(6)
    return ''.join(output_chars)

if __name__ == '__main__':
    # check som obvious things
    check_equals('creat', 'cre' + 'at')
    print(1)
    check_equals('referer', 'refer' + 'er')
    print(2)
    # check th flag
    flag = decrypt_data([53, 41, 85, 109, 75, 1, 33, 48, 77, 90,
                         17, 118, 36, 25, 13, 89, 90, 3, 63, 25,
                         31, 77, 27, 60, 3, 118, 24, 62, 54, 61,
                         25, 63, 77, 36, 5, 32, 60, 67, 113, 28])
    print(7)
    #check_equals(flag.index('flag{'), 0)
    print(8)
    check_equals(flag.index('}'), len(flag) - 1)

    # print th flag
    print(flag)

```
### 第14题

asciinema cat file.rec > output.txt
然后用ansifilter过滤（只看了windows，mac和linux没研究）
之后删几行，直接就可以node code.js跑起来了

### 第15题

![image_2023-10-31_17-15-50](https://github.com/BH3GEI/blog/assets/58540850/f43f5a2a-dd6c-4655-ad1d-8c2d8cc9f225)

第一问只要说I am smart?就行

其他的也只要参考训练数据集上下文应该就可以得出

### 第18题

只做了第一问的压缩
