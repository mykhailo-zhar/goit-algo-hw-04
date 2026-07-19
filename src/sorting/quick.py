"""Quicksort."""


def quicksort(arr: list[int]) -> list[int]:
    """Sort a list of integers using quicksort.

    Chooses the middle element as the pivot, partitions into less-than,
    equal-to, and greater-than parts, then concatenates recursively sorted
    parts. Does not modify the input list for multi-element inputs.

    Args:
        arr: The list of integers to sort.

    Returns:
        A sorted list of the elements of ``arr`` in ascending order.
    """
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    greater_part = [x for x in arr if x > pivot]
    equal_part = [x for x in arr if x == pivot]
    less_part = [x for x in arr if x < pivot]
    return quicksort(less_part) + equal_part + quicksort(greater_part)
