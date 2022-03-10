z = input('chnad meghdar vared konid :')
d = ['pouya', 'maryam', 'ali', 'reyhane']
x = z.split(',')
print(x)
print(d)
list_0 = []
for i in x:
    for j in d:
        if i == j:
            list_0.append(i)
        else:
            continue
            # print('not user')
print(list_0)