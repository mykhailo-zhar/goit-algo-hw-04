def insertion_sort(arr: list[int]) -> list[int]:
    result = arr.copy()
    n = len(arr)
    for i in range(1, n):
        j = i - 1
        key = result[i]
        while j >= 0 and key < result[j]:
            result[j + 1] = result[j]
            j -= 1
        result[j + 1] = key
    return result
