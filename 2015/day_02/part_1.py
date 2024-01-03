#!/usr/bin/env python3

from sys import argv


def log(s):
    try:
        argv[1]
        print(s)
    except IndexError:
        pass


def calculate_wrapping_paper(d):
    l, w, h = [int(i) for i in d.split("x")]
    smallest_side = min(l, w, h)
    box_dimensions = [l, w, h]
    box_dimensions.pop(box_dimensions.index(smallest_side))

    middle, biggest = box_dimensions
    next_smallest_side = min(middle, biggest)

    extra_paper = smallest_side * next_smallest_side

    return (2*l*w) + (2*w*h) + (2*h*l) + extra_paper


def test_examples():
    assert calculate_wrapping_paper("2x3x4") == 58
    assert calculate_wrapping_paper("1x1x10") == 43

    print("Tests passed.")


def puzzle():
    answer = 0
    with open(r"input.txt", "r", encoding="utf-8") as input_file:
        data = input_file.readlines()

        for d in data:
            row = d.strip()
            answer += calculate_wrapping_paper(row)

    print(f"{answer}")


if __name__ == "__main__":
    test_examples()
    puzzle()
