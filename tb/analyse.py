#!/usr/bin/env python3

# This script analyses the performance of the CPU using stdout
# Run "./doit.sh <test> > output.log"
# Author: William Huynh <wh1022@ic.ac.uk>


import argparse
from pathlib import Path
import re
import matplotlib.pyplot as plt


INPUT_FILE = Path(__file__).resolve().parent / "output.log"
OUTPUT_FILE = Path(__file__).resolve().parent / "cache_hit_rate.png"


class DataParser:
    def __init__(self, input_file):
        with open(input_file) as f:
            self.words = [line.strip() for line in f.readlines()]

    def get_data(self):
        current_testbench = None
        current_test = None
        results = []
        stores = 0
        hits = 0
        misses = 0
        start_pattern = r"\[ RUN\s+\] (\S+)\.(\S+)"
        end_pattern = r"\[.+\] (\S+)\.(\S+) \(.+\)"

        for line in self.words:
            start_match = re.match(start_pattern, line)
            end_match = re.match(end_pattern, line)

            if start_match:
                testbench = start_match.group(1)
                test_name = start_match.group(2)

                current_testbench = testbench
                current_test = test_name
                stores = 0
                hits = 0
                misses = 0
            elif end_match:
                hit_rate = 0

                if (hits + misses) != 0:
                    read_hit_rate = (hits / (hits + misses)) * 100
                else:
                    read_hit_rate = 100

                if (hits + misses + stores) != 0:
                    hit_rate = (hits / (hits + misses + stores)) * 100
                else:
                    hit_rate = 100

                results.append({
                    "testbench": current_testbench,
                    "test": current_test,
                    "stores": stores,
                    "hits": hits,
                    "misses": misses,
                    "hit_rate": hit_rate,
                    "read_hit_rate": read_hit_rate
                })
            elif "STORE" in line:
                stores += 1
            elif "HIT" in line:
                hits += 1
            elif "MISS" in line:
                misses += 1
            else:
                # Do nothing
                pass

        return results

    def plot_data(self, results: list, output_file):
        # Extract data for parsing
        test_names = [result["test"] for result in results]
        hit_rate = [result["hit_rate"] for result in results]

        # Create a bar chart
        plt.figure(figsize=(10, 6))
        plt.bar(test_names, hit_rate, color="blue")
        plt.title("Hit Rate Comparison for Different Tests")
        plt.xlabel("Test Name", weight="bold")
        plt.ylabel("Hit Rate (%)", weight="bold")
        plt.ylim(0, 100)
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout(pad=2.0)

        plt.savefig(output_file)


def main():
    parser = argparse.ArgumentParser(
        description="Takes in a log file and extracts data such as data "
        "memory/branch hit rate")

    parser.add_argument(
        "-i", "--input", help="Path to the input file", default=INPUT_FILE)
    parser.add_argument(
        "-o", "--output", help="Path to the output file", default=OUTPUT_FILE)

    args = parser.parse_args()

    input_file = args.input
    output_file = args.output

    dataParser = DataParser(input_file)
    results = dataParser.get_data()
    dataParser.plot_data(results, output_file)


if __name__ == "__main__":
    main()
