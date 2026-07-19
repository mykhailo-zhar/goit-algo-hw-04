def quicksort(arr: list[int]) -> list[int]:
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    greater_part = [x for x in arr if x > pivot]
    equal_part = [x for x in arr if x == pivot]
    less_part = [x for x in arr if x < pivot]
    return quicksort(less_part) + equal_part + quicksort(greater_part)
