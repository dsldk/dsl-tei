import sys
import re
import argparse
import json
from datetime import datetime
from collections import Counter

def load_word_list(word_list_file):
    word_set = set()
    with open(word_list_file, "r", encoding="utf-8") as f:
        for line in f:
            word = line.strip()
            if word:
                word_set.add(word.lower())
    return word_set

def get_words_from_text(text_file):
    with open(text_file, "r", encoding="utf-8") as f:
        text = f.read().lower()
    words = re.findall(r"\b[\wæøåÆØÅ'\.-]+\b", text)
    return words

def log_statistics(log_file, stats):
    try:
        with open(log_file, "r", encoding="utf-8") as f:
            existing_logs = json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        existing_logs = []

    existing_logs.append(stats)

    with open(log_file, "w", encoding="utf-8") as f:
        json.dump(existing_logs, f, ensure_ascii=False, indent=2)

def calculate_deviation(word_list_file, text_files, verbose=False, frequencies=False, total=False, log_file=None):
    known_words = load_word_list(word_list_file)
    total_word_count = 0
    total_unknown_word_count = 0
    total_unknown_words = Counter()

    for text_file in text_files:
        words = get_words_from_text(text_file)
        total_words = len(words)
        total_word_count += total_words
        word_counts = Counter(words)
        unknown_words = {word: count for word, count in word_counts.items() if word not in known_words}
        total_unknown_word_count += sum(unknown_words.values())
        total_unknown_words.update(unknown_words)

        if not total:
            deviation_percentage = (sum(unknown_words.values()) / total_words) * 100 if total_words else 0.0
            print(f"\n--- Analysis for '{text_file}' ---")
            print(f"Total words: {total_words}")
            print(f"Unknown words: {len(unknown_words)}")
            print(f"Deviation percentage: {deviation_percentage:.2f}%")
            if verbose:
                print("\nUnknown words:\n" + ", ".join(sorted(unknown_words.keys())))
            if frequencies:
                print("\nUnknown words sorted by frequency:\n")
                for word, count in sorted(unknown_words.items(), key=lambda x: x[1], reverse=True):
                    print(f"{word}: {count}")

    if total:
        total_deviation_percentage = (total_unknown_word_count / total_word_count) * 100 if total_word_count else 0.0
        print("\n=== Total Analysis for All Texts ===")
        print(f"Total words: {total_word_count}")
        print(f"Total unknown words: {total_unknown_word_count}")
        print(f"Unique unknown words: {len(total_unknown_words)}")
        print(f"Overall deviation percentage: {total_deviation_percentage:.2f}%")
        print("\nUnknown words sorted by frequency (entire corpus):\n")
        for word, count in sorted(total_unknown_words.items(), key=lambda x: x[1], reverse=True):
            print(f"{word}: {count}")

        if log_file:
            stats = {
                "timestamp": datetime.now().isoformat(),
                "total_words": total_word_count,
                "total_unknown_words": total_unknown_word_count,
                "unique_unknown_words": len(total_unknown_words),
                "deviation_percentage": round(total_deviation_percentage, 2)
            }
            log_statistics(log_file, stats)
            print(f"\nLogged results to {log_file}")

def main():
    parser = argparse.ArgumentParser(description="Calculate deviation from a word list in text files.")
    parser.add_argument("word_list", help="The word list file.")
    parser.add_argument("text_files", nargs="+", help="One or more text files to analyze.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Show list of unknown words (alphabetically).")
    parser.add_argument("-f", "--frequencies", action="store_true", help="Show list of unknown words sorted by frequency.")
    parser.add_argument("-t", "--total", action="store_true", help="Show overall analysis for all text files combined, without individual file reports.")
    parser.add_argument("-l", "--log", help="Optional log file to store results (JSON format).")

    args = parser.parse_args()
    calculate_deviation(args.word_list, args.text_files, args.verbose, args.frequencies, args.total, args.log)

if __name__ == "__main__":
    main()

