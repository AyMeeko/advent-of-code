#!/usr/bin/env python3

from sys import argv


def log(s):
    try:
        argv[1]
        print(s)
    except IndexError:
        pass


def count_delivered_houses(path):
    location = (0, 0)
    visited = set([location])
    for direction in path:
        log(f"direction: {direction}, location: {location}")
        if direction == ">":
            new_location = (location[0] + 1, location[1])
        elif direction == "v":
            new_location = (location[0], location[1] - 1)
        elif direction == "<":
            new_location = (location[0] - 1, location[1])
        elif direction == "^":
            new_location = (location[0], location[1] + 1)
        else:
            raise Exception("wtf")
        visited.add(new_location)
        log(f"new_location: {new_location}")
        location = new_location
    return len(visited)


def test_examples():
    assert count_delivered_houses(">") == 2
    assert count_delivered_houses("^>v<") == 4
    assert count_delivered_houses("^v^v^v^v^v") == 2

    print("Tests passed.")


def puzzle():
    answer = 0
    with open(r"input.txt", "r", encoding="utf-8") as input_file:
        data = input_file.readline().strip()
        answer = count_delivered_houses(data)

    print(f"{answer}")


if __name__ == "__main__":
    test_examples()
    puzzle()
