"""
findpattern.py

"""

import sys
import re

# Define the patterns to search for
patterns = [
        r'[a-z]- [a-z]',                    # misplaced hyphen?
        r'[a-z][0-9]',                      # pagenumber within text?
        r'[0-9]\s*</p>',                    # pagenumber within text?
        r'[a-z,;-]\s*</p>\s*?<p>\s*[a-z]',   # wrong <p> ending?
        ]


def check_patterns_in_file(file_path, patterns):
    """
    Check for patterns in a text file and print matching lines.

    Args:
        file_path (str): The path to the text file to be checked.
        patterns (list): A list of regular expression patterns to search for.

    Returns:
        None

    Prints:
        Matching lines in the format: "filename:path:matched_line".
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()

            # Join all lines into a single string
            file_contents = ''.join(lines)

            for pattern in patterns:
                # Use re.DOTALL to enable multiline matching
                pattern_with_flag = re.compile(pattern, re.DOTALL)

                matches = pattern_with_flag.finditer(file_contents)

                for match in matches:
                    # Replace newline with space
                    matched_text = match.group().replace('\n', ' ')
                    # Calculate the line number where the match starts
                    start_line_num = sum(
                        1 for i in file_contents[:match.start()].split('\n'))
                    print(f"{file_path}:{start_line_num}:"
                          f"{matched_text.strip()}")

    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
    except IOError as error:
        print(f"IOError: Error while processing '{file_path}': {error}")
    except re.error as error:
        print(f"RegexError: Error while processing '{file_path}': {error}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python pattern_checker.py <filename1> [<filename2> ...]")
        sys.exit(1)

    for file_path in sys.argv[1:]:
        check_patterns_in_file(file_path, patterns)
