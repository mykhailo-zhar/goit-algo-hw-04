"""Selection sort."""


def selection_sort(arr: list[int]) -> list[int]:
    """Sort a list of integers using selection sort.

    Repeatedly selects the minimum remaining element and swaps it into the
    next position from the left. Does not modify the input list.

    Args:
        arr: The list of integers to sort.

    Returns:
        A new list containing the elements of ``arr`` in ascending order.
    """
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
