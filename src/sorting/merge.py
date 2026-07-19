def merge_sort(arr):
    if len(arr) <= 1:
        return arr

    middle = len(arr) // 2
    left = arr[:middle]
    right = arr[middle:]
    return merge(merge_sort(left), merge_sort(right))


def merge(left, right):
    merged = []
    left_idx, right_idx = 0, 0

    while left_idx < len(left) and right_idx < len(right):
        if left[left_idx] <= right[right_idx]:
            merged.append(left[left_idx])
            left_idx += 1

        else:
            merged.append(right[right_idx])
            right_idx += 1

    merged = merged + left[left_idx:]
    merged = merged + right[right_idx:]

    return merged
