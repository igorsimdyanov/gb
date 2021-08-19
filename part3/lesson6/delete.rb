arr = [1, 2, 3, 2, 4, 2, 5]

p arr.delete(2) # 2
p arr           # [1, 3, 4, 5]

p arr.delete(200) # nil
p arr

p arr.delete(200) { 'нет такого индекса' }
