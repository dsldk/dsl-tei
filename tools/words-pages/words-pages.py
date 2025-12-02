#!/usr/bin/env python3
import sys
import math
from pathlib import Path
from lxml import etree

WORDS_PER_PAGE = 250

def extract_text_with_xslt(xml_file, xslt_file):
    """Apply XSLT to TEI XML and return extracted text."""
    xml_tree = etree.parse(str(xml_file))
    xslt_tree = etree.parse(str(xslt_file))
    transform = etree.XSLT(xslt_tree)
    result_tree = transform(xml_tree)
    return str(result_tree)

def count_words(text):
    """Count words in a string."""
    return len(text.split())

def process_file(xml_file, xslt_file):
    """Process a single XML file and return word count."""
    text = extract_text_with_xslt(xml_file, xslt_file)
    word_count = count_words(text)
    page_count = math.ceil(word_count / WORDS_PER_PAGE)
    print(f"{xml_file}: {word_count} words, ~{page_count} pages")
    return word_count

def process_path(input_path, xslt_file):
    """Process a path (file or directory) and print totals."""
    path = Path(input_path)
    total_words = 0

    files = []
    if path.is_file() and path.suffix.lower() == ".xml":
        files = [path]
    elif path.is_dir():
        files = list(path.rglob("*.xml"))
    else:
        print(f"Skipping {input_path}: not an XML file or directory")
        return

    for xml_file in files:
        words = process_file(xml_file, xslt_file)
        total_words += words

    total_pages = math.ceil(total_words / WORDS_PER_PAGE)
    print("\n=== TOTALS ===")
    print(f"Total words: {total_words}")
    print(f"Total pages (@{WORDS_PER_PAGE} words/page): ~{total_pages}")

def main():
    if len(sys.argv) != 3:
        print("Usage: python tei_to_text_count.py <xml-file-or-dir> <stylesheet.xsl>")
        sys.exit(1)

    input_path = sys.argv[1]
    xslt_file = sys.argv[2]
    process_path(input_path, xslt_file)

if __name__ == "__main__":
    main()
