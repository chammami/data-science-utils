class Colors:
    """Defining Color Codes to color the text displayed on terminal.
    """

    blue = "\033[94m"
    green = "\033[92m"
    yellow = "\033[93m"
    red = "\033[91m"
    end = "\033[0m"


def color(string: str, color: Colors = Colors.yellow) -> str:
    return f"{color}{string}{Colors.end}"


@contextmanager
def timer(label: str) -> None:
    """compute the time the code block takes to run.
    """
    p = psutil.Process(os.getpid())
    start = time()  # Setup - __enter__
    m0 = p.memory_info()[0] / 2. ** 30
    print(color(f"{label}: Start at {start}; RAM USAGE AT START {m0}"))
    try:
        yield  # yield to body of `with` statement
    finally:  # Teardown - __exit__
        m1 = p.memory_info()[0] / 2. ** 30
        delta = m1 - m0
        sign = '+' if delta >= 0 else '-'
        delta = math.fabs(delta)
        end = time()
        print(color(f"{label}: End at {end} ({end - start} elapsed); RAM USAGE AT END {m1:.2f}GB ({sign}{delta:.2f}GB)", color=Colors.red))


import psutil
import os
import time
import sys
import math
from contextlib import contextmanager

@contextmanager
def trace(title):
    t0 = time.time()
    p = psutil.Process(os.getpid())
    m0 = p.memory_info()[0] / 2. ** 30
    yield
    m1 = p.memory_info()[0] / 2. ** 30
    delta = m1 - m0
    sign = '+' if delta >= 0 else '-'
    delta = math.fabs(delta)
    print(f"[{m1:.1f}GB({sign}{delta:.1f}GB):{time.time() - t0:.1f}sec] {title} ", file=sys.stderr)
