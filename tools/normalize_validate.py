#!/usr/bin/python3

"""
normalize_validate.py

"""

import sys
import os
import re
from lxml import etree

def validate_and_pretty_print(filename, schema):
    """
    Validate and pretty-print the XML file.

    """
    try:
        # Check if the schema file exists
        if not os.path.isfile(schema):
            print(f"Error: XSD schema file '{schema}' not found.")
            return

        # Parse the XML file
        parser = etree.XMLParser(remove_blank_text=True)
        tree = etree.parse(filename, parser)

        # Create an XSD validator
        xsd_validator = etree.XMLSchema(etree.parse(schema))

        # Validate the XML against the XSD schema
        if xsd_validator.validate(tree):
            print(f"File: '{filename}' is valid according to the XSD schema.")
        else:
            print(f"File: '{filename}' is not valid according to the XSD schema.")

        # Serialize and pretty-print the XML with indentation and line breaks
        xml_str = etree.tostring(tree, encoding='utf-8', xml_declaration=True, pretty_print=True)

        # Decode the XML to a string
        cleaned_xml_str = xml_str.decode("utf-8")

        # Remove blank lines
        cleaned_lines = [line for line in cleaned_xml_str.splitlines() if line.strip()]

        # Join the non-blank lines
        cleaned_xml_str = "\n".join(cleaned_lines)
        #wrapped_xml_str = "\n".join(textwrap.fill(line, width=70) for line in cleaned_lines)

        # Write the modified XML back to the same file
        with open(filename, "w", encoding="utf-8") as file:
            file.write(cleaned_xml_str)

        print(f"File: '{filename}' has been pretty-printed, had blank lines removed, and modified.")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
    except Exception as e:
        print(f"Error: An error occurred while processing '{filename}': {e}")

def regex_search_and_replace(xml_file, replacements):
    """
    Search after patterns and replace if found.

    """
    try:
        with open(xml_file, 'r', encoding='utf-8') as file:
            xml_content = file.read()

        # Perform regex search and replace for each pattern-replacement pair
        for pattern, replacement in replacements:
            xml_content = re.sub(pattern, replacement, xml_content)

        # Write the modified content back to the file
        with open(xml_file, 'w', encoding='utf-8') as file:
            file.write(xml_content)

        print(f"Regex search and replace in '{xml_file}' completed.")

    except Exception as e:
        print(f"Error: An error occurred during regex search and replace in '{xml_file}': {e}")


def find_dev_directory(start_dir):
    """
    Find the dsl-workspace directory by assuming that
    the XML-file is placed somewhere below it.
    """
    current_dir = os.path.abspath(start_dir)
    while current_dir:
        if os.path.basename(current_dir) == 'dsl-workspace':
            return current_dir
        # Move up one directory
        current_dir = os.path.dirname(current_dir)
    return None

def process_file(xml_file):
    """
    Process XML file
        1. find current working directory
        2. find the dsl-workspace directory, and
        3. locate schema
    and validate

    """
    if not os.path.isfile(xml_file) or not xml_file.lower().endswith(".xml"):
        print(f"Warning: Skipping '{xml_file}' (not a valid XML file).")
        return
    replacements = [
            (r'(<pb[^>]*>)\s*(<p[^>]*>)', r'\2 \1'),    # Move pb inside p
            (r'<pb\/>', r'<pb ed="A" n=""/>'),          # Fix empty pb
            (r'<lb rend="="\/>', ''),                   # Remove lb with @rend
            (r'’', "'")                                 # Punctuation: ’ -> '
    ]
    regex_search_and_replace(xml_file, replacements)
    file_dir = os.path.abspath(os.path.dirname(xml_file))
    start_dir = find_dev_directory(file_dir)
    schema = os.path.join(start_dir, 'dsl-tei/xsd/dsl-tei.xsd')
    validate_and_pretty_print(xml_file, schema)

if __name__ == "__main__":
    # Check if at least one XML file is provided as an argument
    if len(sys.argv) < 2:
        print("Usage: python xml_pretty_printer_validator.py <filename1> [<filename2> ...]")
        sys.exit(1)

    # Process each XML file provided as an argument
    for filename in sys.argv[1:]:
        process_file(filename)
