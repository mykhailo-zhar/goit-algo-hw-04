"""Shared sorting tests, analogous to spec/sort_spec.rb."""

from __future__ import annotations

import random
from collections.abc import Callable

import pytest

from src.sorting.insertion import insertion_sort
from src.sorting.merge import merge_sort
from src.sorting.quick import quicksort
from src.sorting.selection import selection_sort

SortFn = Callable[[list[int]], list[int]]

SORT_ALGORITHMS: list[pytest.ParameterSet] = [
    pytest.param(insertion_sort, id="insertion"),
    pytest.param(merge_sort, id="merge"),
    pytest.param(quicksort, id="quick"),
    pytest.param(selection_sort, id="selection"),
]


@pytest.mark.parametrize("sort_fn", SORT_ALGORITHMS)
def test_sorts_the_array(sort_fn: SortFn) -> None:
    array = [random.randint(0, 99) for _ in range(10)]
    assert sort_fn(array.copy()) == sorted(array)
