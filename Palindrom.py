n1 = int(input("Введите целое число: "))
revers = 0  #обратное число
original1 = n1
arr1 = []
original2 = n1
while original1 > 0:
    digit = original1 % 10
    original1 = original1 // 10
    revers = revers * 10
    revers = revers + digit  
revers1 = revers
key = True
while original2 > 0:
  digit1 = original2 % 10
  digit2 = revers1 % 10
  if digit1 != digit2:
    key = False
    break
  original2 = original2 // 10
  revers1 = revers1 // 10

if key == True:
  print("Число является палиндромом")
else:
  print("Число не является палиндромом")