#!/usr/bin/env python3

# This script analyses the performance of the CPU using stdout
# Run "./doit.sh <test> > output.log"
# To get full guide, see the README.md file, or use --help

# Author: William Huynh <wh1022@ic.ac.uk>


import argparse
import statistics
import subprocess
import shutil
import os
from pathlib import Path
import re
import matplotlib.pyplot as plt


# Global constants
PARENT_DIR = Path(__file__).resolve().parent
INPUT_FILE = PARENT_DIR / "output.log"
OUTPUT_FOLDER = PARENT_DIR / "graphs"
DATA_FOLDER = PARENT_DIR / "data"
RTL_FOLDER = PARENT_DIR.parent / "rtl"

CACHE_DATA_NAME = "cache_data.png"
BRANCH_DATA_NAME = "branch_data.png"
PLOT_NAME = "plot.png"


class DataParser:
    def __init__(self, input_file):
        with open(input_file) as f:
            self.words = [line.strip() for line in f.readlines()]

    def get_data(self):
        start_pattern = r"\[ RUN\s+\] (\S+)\.(\S+)"
        end_pattern = r"\[.+\] (\S+)\.(\S+) \(.+\)"

        # Initialise variables
        results = []
        current_testbench = None
        current_test = None
        stores = 0
        hits = 0
        misses = 0
        branches = 0
        no_branches = 0

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
                branches = 0
                no_branches = 0

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
                    "branches": branches,
                    "no_branches": no_branches,
                    "hit_rate": hit_rate,
                    "read_hit_rate": read_hit_rate
                })

            elif "STORE" in line:
                stores += 1
            elif "HIT" in line:
                hits += 1
            elif "MISS" in line:
                misses += 1
            elif "NOT BRANCH" in line:
                # Must be before next line
                no_branches += 1
            elif "BRANCH" in line:
                branches += 1
            else:
                # Do nothing
                pass

        return results

    def plot_cache_data(self, results: list, output_folder):
        # Extract data for parsing
        test_names = [result["test"] for result in results]
        hit_rate = [result["hit_rate"] for result in results]

        print("Cache median hit rate (%): " +
              str(statistics.median(hit_rate)))
        print("Cache mean hit rate (%): " +
              str(statistics.mean(hit_rate)))
        print("Cache hit rate s.d. (%): " +
              str(statistics.stdev(hit_rate)))

        # Create a bar chart
        plt.figure(figsize=(10, 6))
        plt.bar(test_names, hit_rate, color="blue")
        plt.title("Cache Hit Rate Comparison for Different Tests")
        plt.xlabel("Test Name", weight="bold")
        plt.ylabel("Hit Rate (%)", weight="bold")
        plt.ylim(0, 100)
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout(pad=2.0)

        plt.savefig(output_folder / CACHE_DATA_NAME, dpi=300)

    def plot_branch_data(self, results: list, output_folder):
        # Extract data for parsing
        test_names = [result["test"] for result in results]
        hit_rate = [
            100 * result["no_branches"] /
            max((result["no_branches"] + result["branches"]), 1)
            for result in results
        ]

        print("Branch median hit rate (%): " +
              str(statistics.median(hit_rate)))
        print("Branch mean hit rate (%): " +
              str(statistics.mean(hit_rate)))
        print("Branch hit rate s.d. (%): " +
              str(statistics.stdev(hit_rate)))

        # Create a bar chart
        plt.figure(figsize=(10, 6))
        plt.bar(test_names, hit_rate, color="blue")
        plt.title("Branch Hit Rate Comparison for Different Tests")
        plt.xlabel("Test Name", weight="bold")
        plt.ylabel("Hit Rate (%)", weight="bold")
        plt.ylim(0, 100)
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout(pad=2.0)

        plt.savefig(output_folder / BRANCH_DATA_NAME, dpi=300)


class PDFDataPlotter:
    def __init__(self, input_file):
        with open(input_file) as f:
            self.words = [int(line.strip())
                          for line in f.readlines() if line.strip().isnumeric()]

    def plot_pdf(self, name, output_folder):
        plt.figure(figsize=(10, 6))
        plt.title(f"PDF plot - {name.title()}", pad=15)
        plt.xlabel("Samples [n]", labelpad=15)
        plt.ylabel("Frequency", labelpad=15)

        # Plot the data
        y_vals = self.words
        x_vals = range(len(y_vals))

        plt.plot(x_vals, y_vals, linestyle="-", color="C0", linewidth=2)

        plt.xticks(fontsize=8)
        plt.yticks(fontsize=8)

        # Add a grid for better readability
        plt.grid(True, linestyle='--', alpha=0.7)

        plt.savefig(output_folder / (name + ".png"), dpi=300)


class Demo:
    def __init__(self):
        file_names = [os.path.splitext(f)[0] for f in os.listdir(DATA_FOLDER)
                      if os.path.isfile(os.path.join(DATA_FOLDER, f))]

        for name in file_names:
            # Move data to the right place
            print(f"Processing {name}.mem...")
            shutil.copy(DATA_FOLDER / f"{name}.mem", RTL_FOLDER / "data.hex")

            log_filepath = f"{name}.log"

            # Run the ./doit.sh command to run the PDF
            with open(log_filepath, "w") as log_file:
                subprocess.run(
                    ["./doit.sh", "test/top-pdf_tb.cpp"],
                    stdout=log_file,
                    stderr=subprocess.DEVNULL,
                    text=True
                )

            pdf_data_plotter = PDFDataPlotter(log_filepath)
            pdf_data_plotter.plot_pdf(name, OUTPUT_FOLDER)

        print(f"Complete! Results can be found here: {OUTPUT_FOLDER}")


def analyse(input_file):
    data_parser = DataParser(input_file)
    results = data_parser.get_data()
    data_parser.plot_cache_data(results, OUTPUT_FOLDER)
    data_parser.plot_branch_data(results, OUTPUT_FOLDER)


def plot(input_file, name):
    pdf_data_plotter = PDFDataPlotter(input_file)
    pdf_data_plotter.plot_pdf(name, OUTPUT_FOLDER)


def demo():
    showDemo = Demo()


def main():
    parser = argparse.ArgumentParser(
        description="Takes in a log file and extracts data such as data "
        "memory/branch hit rate")

    subparsers = parser.add_subparsers(title="Available Modes", dest="mode")

    # Run analysis
    analyse_parser = subparsers.add_parser(
        "run", help="Run analysis of the instruction testbench (top-instr_tb.cpp)")
    analyse_parser.add_argument(
        "-i", "--input", help="Path to the input log file", default=INPUT_FILE)
    analyse_parser.set_defaults(func=analyse)

    # Plot
    plot_parser = subparsers.add_parser(
        "plot", help="Plot a PDF graph using the PDF testbench (top-pdf_tb.cpp)")
    plot_parser.add_argument(
        "-i", "--input", help="Path to the input data log file", required=True)
    plot_parser.add_argument(
        "-n", "--name", help="Name of the plot")
    plot_parser.set_defaults(func=plot)

    # Demo
    demo_parser = subparsers.add_parser(
        "demo", help="Run the whole PDF testbench and automatically plot the "
        "graphs, without any need for inputs"
    )
    demo_parser.set_defaults(func=demo)

    args = parser.parse_args()

    OUTPUT_FOLDER.mkdir(parents=True, exist_ok=True)

    if args.mode == 'run':
        args.func(args.input)
    elif args.mode == "plot":
        if not args.name:
            name = Path(args.input).stem
        else:
            name = args.name

        args.func(args.input, name)
    elif args.mode == "demo":
        args.func()
    else:
        print("Invalid option")


if __name__ == "__main__":
    main()
