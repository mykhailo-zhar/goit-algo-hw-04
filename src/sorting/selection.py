def selection_sort(arr: list[int]) -> list[int]:
    result = arr.copy()
    n = len(arr)
    for i in range(n - 1):
        min_index = i
        j = i + 1
        while j < n:
            if result[j] < result[min_index]:
                min_index = j
            j += 1

        sw = result[min_index]
        result[min_index] = result[i]
        result[i] = sw
    return result
