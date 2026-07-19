"""Merge sort."""


def merge_sort(arr: list[int]) -> list[int]:
    """Sort a list of integers using merge sort.

    Recursively splits the list in half, sorts each half, then merges the
    sorted halves. For lists of length 0 or 1, returns ``arr`` as-is.

    Args:
        arr: The list of integers to sort.

    Returns:
        A sorted list of the elements of ``arr`` in ascending order.
    """
    if len(arr) <= 1:
        return arr

    middle = len(arr) // 2
    left = arr[:middle]
    right = arr[middle:]
    return merge(merge_sort(left), merge_sort(right))


def merge(left: list[int], right: list[int]) -> list[int]:
    """Merge two sorted lists into one sorted list.

    Args:
        left: A list already sorted in ascending order.
        right: A list already sorted in ascending order.

    Returns:
        A new list containing all elements from ``left`` and ``right``
        in ascending order.
    """
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
