import sys
import re
import argparse
from collections import Counter

def load_word_list(word_list_file):
    """Load words from a word list file, treating them as plain text."""
    word_set = set()
    with open(word_list_file, "r", encoding="utf-8") as f:
        for line in f:
            word = line.strip()  # Remove spaces and newlines
            if word:  # Ignore empty lines
                word_set.add(word.lower())  # Normalize to lowercase
    return word_set

def get_words_from_text(text_file):
    """Extract words from a text file, handling punctuation and special cases."""
    with open(text_file, "r", encoding="utf-8") as f:
        text = f.read().lower()
    
    # Regex to capture words including apostrophes and hyphens
    #words = re.findall(r"\b[\wæøåÆØÅ'-]+\b", text)
    
    words = re.findall(r"\b[\wæøåÆØÅ'\.-]+\b", text)
    # Regex to capture words and abbreviations
    #words = re.findall(r"\b[\wæøåÆØÅ'-]+(?:\.[\wæøåÆØÅ'-]+)*\.?\b", text)

    # Strip trailing punctuation that is not part of the word
    #words = [word.rstrip(",:;!?") for word in words]

    
    return words

def calculate_deviation(word_list_file, text_files, verbose=False, frequencies=False, total=False):
    """Compare text files to the word list and compute deviation percentage."""
    known_words = load_word_list(word_list_file)

    total_word_count = 0
    total_unknown_word_count = 0
    total_unknown_words = Counter()

    for text_file in text_files:
        words = get_words_from_text(text_file)
        total_words = len(words)
        total_word_count += total_words

        # Count word frequencies
        word_counts = Counter(words)

        # Get unknown words
        unknown_words = {word: count for word, count in word_counts.items() if word not in known_words}
        total_unknown_word_count += sum(unknown_words.values())
        total_unknown_words.update(unknown_words)

        # Skip per-file analysis if -t (total) is enabled
        if not total:
            if total_words == 0:
                deviation_percentage = 0.0  # Avoid division by zero
            else:
                deviation_percentage = (sum(unknown_words.values()) / total_words) * 100

            print(f"\n--- Analysis for '{text_file}' ---")
            print(f"Total words: {total_words}")
            print(f"Unknown words: {len(unknown_words)}")
            print(f"Deviation percentage: {deviation_percentage:.2f}%")

            # Verbose mode: List unknown words alphabetically
            if verbose:
                print("\nUnknown words:\n" + ", ".join(sorted(unknown_words.keys())))

            # Frequencies mode: List unknown words sorted by occurrence
            if frequencies:
                print("\nUnknown words sorted by frequency:\n")
                for word, count in sorted(unknown_words.items(), key=lambda x: x[1], reverse=True):
                    print(f"{word}: {count}")

    # If total option is enabled, print summary for the entire corpus
    if total:
        if total_word_count == 0:
            total_deviation_percentage = 0.0  # Avoid division by zero
        else:
            total_deviation_percentage = (total_unknown_word_count / total_word_count) * 100

        print("\n=== Total Analysis for All Texts ===")
        print(f"Total words: {total_word_count}")
        print(f"Total unknown words: {len(total_unknown_words)}")
        print(f"Overall deviation percentage: {total_deviation_percentage:.2f}%")
        print(f"Overall deviation percentage: {total_deviation_percentage}%")


        print("\nUnknown words sorted by frequency (entire corpus):\n")
        for word, count in sorted(total_unknown_words.items(), key=lambda x: x[1], reverse=True):
            print(f"{word}: {count}")

def main():
    parser = argparse.ArgumentParser(description="Calculate deviation from a word list in text files.")
    parser.add_argument("word_list", help="The word list file.")
    parser.add_argument("text_files", nargs="+", help="One or more text files to analyze.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Show list of unknown words (alphabetically).")
    parser.add_argument("-f", "--frequencies", action="store_true", help="Show list of unknown words sorted by frequency.")
    parser.add_argument("-t", "--total", action="store_true", help="Show overall analysis for all text files combined, without individual file reports.")

    args = parser.parse_args()

    calculate_deviation(args.word_list, args.text_files, args.verbose, args.frequencies, args.total)

if __name__ == "__main__":
    main()
