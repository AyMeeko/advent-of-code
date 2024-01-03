#!/usr/bin/env python3

from sys import argv


def log(s):
    try:
        argv[1]
        print(s)
    except IndexError:
        pass


def count_delivered_houses(path):
    santa_location = (0, 0)
    robot_location = (0, 0)
    visited = set([santa_location])
    is_santa = True
    for direction in path:
        location = santa_location if is_santa else robot_location

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
        if is_santa:
            santa_location = new_location
        else:
            robot_location = new_location
        is_santa = not is_santa
    return len(visited)


def test_examples():
    assert count_delivered_houses("^v") == 3
    assert count_delivered_houses("^>v<") == 3
    assert count_delivered_houses("^v^v^v^v^v") == 11

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
