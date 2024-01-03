#!/usr/bin/env python3

from sys import argv


def log(s):
    try:
        argv[1]
        print(s)
    except IndexError:
        pass


def method(param):
    pass


def parse_input_file(file_name):
    with open(file_name, "r", encoding="utf-8") as input_file:
        data = input_file.readlines()

        for d in data:
            row = d.strip()

    return row


def test_examples():
    row = parse_input_file(r"test_input.txt")

    assert row == 0

    print("Tests passed.")


def puzzle():
    answer = parse_input_file(r"test_input.txt")

    print(f"{answer}")


if __name__ == "__main__":
    test_examples()
    # puzzle()
