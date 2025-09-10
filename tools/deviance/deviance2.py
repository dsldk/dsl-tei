import sys
import re
import argparse
from collections import Counter

def load_word_list(word_list_file):
    """Load words from a large word list file efficiently."""
    word_set = set()
    with open(word_list_file, "r", encoding="utf-8") as f:
        for line in f:
            word = line.strip()
            if word:
                word_set.add(word.lower())  # Normalize to lowercase
    return word_set

def process_text_file(text_file, known_words):
    """Process a text file line by line, extracting words and counting unknowns."""
    total_word_count = 0
    unknown_words_counter = Counter()
    
    with open(text_file, "r", encoding="utf-8") as f:
        for line in f:
            words = re.findall(r"\b[\wæøåÆØÅ'-]+\b", line.lower())  # Extract words
            total_word_count += len(words)
            for word in words:
                if word not in known_words:
                    unknown_words_counter[word] += 1
    
    return total_word_count, unknown_words_counter

def calculate_deviation(word_list_file, text_files, verbose=False, frequencies=False, total=False):
    """Compare text files to the word list and compute deviation efficiently."""
    known_words = load_word_list(word_list_file)

    total_word_count = 0
    total_unknown_words = Counter()

    for text_file in text_files:
        file_word_count, unknown_words = process_text_file(text_file, known_words)
        total_word_count += file_word_count
        total_unknown_words.update(unknown_words)

        # Skip per-file analysis if -t (total) is enabled
        if not total:
            deviation_percentage = (sum(unknown_words.values()) / file_word_count * 100) if file_word_count > 0 else 0
            print(f"\n--- Analysis for '{text_file}' ---")
            print(f"Total words: {file_word_count}")
            print(f"Unknown words: {len(unknown_words)}")
            print(f"Deviation percentage: {deviation_percentage:.2f}%")

            if verbose:
                print("\nUnknown words:\n" + ", ".join(sorted(unknown_words.keys())))

            if frequencies:
                print("\nUnknown words sorted by frequency:\n")
                for word, count in sorted(unknown_words.items(), key=lambda x: x[1], reverse=True):
                    print(f"{word}: {count}")

    # If total mode is enabled, print summary for all files combined
    if total:
        total_deviation_percentage = (sum(total_unknown_words.values()) / total_word_count * 100) if total_word_count > 0 else 0
        print("\n=== Total Analysis for All Texts ===")
        print(f"Total words: {total_word_count}")
        print(f"Total unknown words: {len(total_unknown_words)}")
        print(f"Overall deviation percentage: {total_deviation_percentage:.2f}%")

        print("\nUnknown words sorted by frequency (entire corpus):\n")
        for word, count in sorted(total_unknown_words.items(), key=lambda x: x[1], reverse=True):
            print(f"{word}: {count}")

def main():
    parser = argparse.ArgumentParser(description="Calculate deviation from a word list in text files efficiently.")
    parser.add_argument("word_list", help="The word list file.")
    parser.add_argument("text_files", nargs="+", help="One or more text files to analyze.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Show list of unknown words (alphabetically).")
    parser.add_argument("-f", "--frequencies", action="store_true", help="Show list of unknown words sorted by frequency.")
    parser.add_argument("-t", "--total", action="store_true", help="Show overall analysis for all text files combined, without individual file reports.")

    args = parser.parse_args()

    calculate_deviation(args.word_list, args.text_files, args.verbose, args.frequencies, args.total)

if __name__ == "__main__":
    main()

