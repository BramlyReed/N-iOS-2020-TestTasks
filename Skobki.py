
s = input("Введите строку: ")
subs = input("Введите подстроку: ") 
begin = -1
end = -1
count_open = 0
i = 0
while i < len(s):
    if s[i] == '[':
        count_open += 1
        begin = i
        break
    i += 1
i += 1
while i < len(s):
    if s[i] == '[':
        count_open += 1
    elif s[i] == ']':
        count_open -= 1
        if count_open == 0:
            end = i
            break
    i += 1
print('%s%s%s' % (s[:begin], subs, s[end+1:]))