#!/usr/bin/env python3

from sys import argv


def log(s):
    try:
        argv[1]
        print(s)
    except IndexError:
        pass


def calculate_ribbon(d):
    l, w, h = [int(i) for i in d.split("x")]
    smallest_side = min(l, w, h)
    box_dimensions = [l, w, h]
    box_dimensions.pop(box_dimensions.index(smallest_side))

    middle, biggest = box_dimensions
    next_smallest_side = min(middle, biggest)

    extra_ribbon = l * w * h

    return (2 * smallest_side) + (2 * next_smallest_side) + extra_ribbon


def test_examples():
    assert calculate_ribbon("2x3x4") == 34
    assert calculate_ribbon("1x1x10") == 14

    print("Tests passed.")


def puzzle():
    answer = 0
    with open(r"input.txt", "r", encoding="utf-8") as input_file:
        data = input_file.readlines()

        for d in data:
            row = d.strip()
            answer += calculate_ribbon(row)

    print(f"{answer}")


if __name__ == "__main__":
    test_examples()
    puzzle()
