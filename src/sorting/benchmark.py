import random
import timeit
from typing import Callable

from .insertion import insertion_sort
from .merge import merge_sort
from .quick import quicksort


def create_random_array(size: int) -> list[int]:
    return [random.randint(0, 100) for _ in range(size)]


def create_sorted_array(size: int) -> list[int]:
    return [i for i in range(size)]


def create_reversed_array(size: int) -> list[int]:
    return create_sorted_array(size)[::-1]


def create_nearly_sorted_array(
    size: int, swap_chance: float = 0.5, max_swap_distance: int = 10
) -> list[int]:
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
    print(
        "  {sample_name}: {benchmark_time:.8f} ms".format(
            sample_name=sample_name,
            benchmark_time=timeit.timeit(lambda: sort_algorithm(array), number=1)
            * 1000,
        )
    )


def benchmark():

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

    for sample_size in [10, 1000, 10000]:
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
