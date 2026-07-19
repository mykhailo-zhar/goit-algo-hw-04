"""Koch Flake

The Koch Flake is a fractal that is created by starting with a triangle and then
adding triangles to the sides of the triangle.
"""

from __future__ import annotations

import argparse
import turtle


def koch_curve(t: turtle.Turtle, order: int, size: float) -> None:
    if order == 0:
        t.forward(size)
        return

    for angle in (60, -120, 60, 0):
        koch_curve(t, order - 1, size / 3)
        t.left(angle)


def koch_flake(t: turtle.Turtle, order: int, size: float) -> None:
    for _ in range(3):
        koch_curve(t, order, size)
        t.right(120)


if __name__ == "__main__":
    window = turtle.Screen()
    window.bgcolor("white")

    parser = argparse.ArgumentParser()
    parser.add_argument("--order", type=int, nargs="?", const=3, default=3)
    parser.add_argument("--size", type=float, nargs="?", const=300, default=300)
    args = parser.parse_args()

    t = turtle.Turtle()
    t.speed(0)
    t.penup()
    t.goto(-args.size / 2, 0)
    t.pendown()
    t.speed(0)
    koch_flake(t, args.order, args.size)
    t.hideturtle()

    window.mainloop()
