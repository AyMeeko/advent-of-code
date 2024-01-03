#!/usr/bin/env python3

from sys import argv


def log(s):
    try:
        argv[1]
        print(s)
    except IndexError:
        pass


def follow_instructions(instructions):
    floor = 0
    steps = 0
    for c in instructions:
        if c == "(":
          floor += 1
        else:
          floor -= 1
        steps += 1
        if floor == -1:
          break

    return steps


def test_examples():
    assert follow_instructions(")") == 1
    assert follow_instructions("()())") == 5

    print("Tests passed.")


def puzzle():
    data = None
    with open(r"input.txt", "r", encoding="utf-8") as input_file:
        data = input_file.readlines()[0].strip()

    answer = follow_instructions(data)

    print(f"{answer}")


if __name__ == "__main__":
    test_examples()
    puzzle()
