"""Benchmark helpers for comparing sorting algorithms."""

import random
import timeit
from typing import Callable

from .insertion import insertion_sort
from .merge import merge_sort
from .quick import quicksort


def create_random_array(size: int) -> list[int]:
    """Create a list of ``size`` random integers in ``[0, 100]``.

    Args:
        size: Number of elements to generate.

    Returns:
        A list of random integers.
    """
    return [random.randint(0, 100) for _ in range(size)]


def create_sorted_array(size: int) -> list[int]:
    """Create a list of integers from ``0`` to ``size - 1``.

    Args:
        size: Number of elements to generate.

    Returns:
        An ascending sequence of consecutive integers.
    """
    return [i for i in range(size)]


def create_reversed_array(size: int) -> list[int]:
    """Create a list of integers from ``size - 1`` down to ``0``.

    Args:
        size: Number of elements to generate.

    Returns:
        A descending sequence of consecutive integers.
    """
    return create_sorted_array(size)[::-1]


def create_nearly_sorted_array(
    size: int, swap_chance: float = 0.5, max_swap_distance: int = 10
) -> list[int]:
    """Create a mostly sorted list with occasional nearby swaps.

    Starts from a sorted array and, for each index, swaps with a nearby
    index with probability ``swap_chance``.

    Args:
        size: Number of elements to generate.
        swap_chance: Probability of swapping each element with a neighbor.
        max_swap_distance: Maximum distance (in indices) for a swap.

    Returns:
        A nearly sorted list of integers.
    """
    result = create_sorted_array(size)
    n = len(result)
    for i in range(n):
        if random.random() < swap_chance:
            j = random.randint(
                max(0, i - max_swap_distance),
                min(n - 1, i + max_swap_distance),
            )
            result[i], result[j] = result[j], result[i]
    return result


def benchmark_sort(
    sort_algorithm: Callable[[list[int]], list[int]],
    array: list[int],
    sort_algorithm_name: str = "sort_algorithm",
    sample_name: str = "array",
) -> None:
    """Time one run of ``sort_algorithm`` on ``array`` and print the result.

    Args:
        sort_algorithm: Sorting function that accepts a list of integers.
        array: Input list to sort (passed as-is to the algorithm).
        sort_algorithm_name: Label for the algorithm (currently unused in
            the printed line).
        sample_name: Label for the input sample printed with the timing.
    """
    print(
        "  {sample_name}: {benchmark_time:.8f} ms".format(
            sample_name=sample_name,
            benchmark_time=timeit.timeit(lambda: sort_algorithm(array), number=1)
            * 1000,
        )
    )


def benchmark() -> None:
    """Run timing comparisons across algorithms, sample types, and sizes.

    Benchmarks insertion sort, merge sort, quicksort, and ``sorted``
    (Timsort) on random, sorted, reversed, and nearly sorted arrays of
    sizes 10, 100, 1000, and 10000. Prints timings in milliseconds.
    """
    SORT_ALGORITHMS = {
        "insertion_sort": insertion_sort,
        "merge_sort": merge_sort,
        "quick_sort": quicksort,
        #        "selection": selection_sort,
        "timsort": sorted,
    }

    ARRAY_TYPES = {
        "random": create_random_array,
        "sorted": create_sorted_array,
        "worst": create_reversed_array,
        "nearly_sorted": create_nearly_sorted_array,
    }

    for sample_size in [10, 100, 1000, 10000]:
        print(f"Sample size: {sample_size}")
        print("-" * 10)
        for sort_algorithm_name, sort_algorithm in SORT_ALGORITHMS.items():
            print(f"{sort_algorithm_name}:")
            for array_name, array_type in ARRAY_TYPES.items():
                benchmark_sort(
                    sort_algorithm,
                    array_type(sample_size),
                    sort_algorithm_name,
                    array_name,
                )
        print("\n" * 2)


if __name__ == "__main__":
    benchmark()
