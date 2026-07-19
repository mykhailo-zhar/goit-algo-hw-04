"""Insertion sort."""


def insertion_sort(arr: list[int]) -> list[int]:
    """Sort a list of integers using insertion sort.

    Builds a sorted result by inserting each element into its correct
    position among the elements already considered. Does not modify the
    input list.

    Args:
        arr: The list of integers to sort.

    Returns:
        A new list containing the elements of ``arr`` in ascending order.
    """
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
