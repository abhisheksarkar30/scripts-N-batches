import os
import shutil
import time
import sys
from os import path


def main():
    # parse file name
    dot_index = sys.argv[1].rfind(".")
    file_name = sys.argv[1] if dot_index == -1 else sys.argv[1][: dot_index]
    extension = "" if dot_index == -1 else sys.argv[1][dot_index + 1:]
    count = int(sys.argv[2])
    destination = "copies"

    if path.exists(sys.argv[1]):
        # get the path to the file in the current directory
        src = path.realpath(sys.argv[1])

    if not os.path.exists(destination):
        os.makedirs(destination)

    # separate the path from the filter
    head, tail = path.split(src)
    print("path:" + head)
    print("file:" + tail)

    initial = time.perf_counter()
    for index in range(count):
        # now use the shell to make a copy of the file
        shutil.copy(src, head + "\\" + destination + "\\" + file_name + str(index) + extension)

    final = time.perf_counter()
    print("Time elapsed: ", final - initial)


if __name__ == "__main__":
    main()
