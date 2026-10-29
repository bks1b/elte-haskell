state = 0
def test(n):
    global state
    state += n
    return state

# Nincs hivatkozási helyfüggetlenség:
print(test(1)) # 1
print(test(1)) # 2 ≠ 1
print(test(2)) # 4
print(test(2)) # 6 ≠ 4
