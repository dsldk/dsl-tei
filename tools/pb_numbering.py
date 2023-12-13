#!/usr/bin/python3

"""
pb_numbering.py

"""

import os
import sys
import xml.etree.ElementTree as ET

def process_pb_elements(xml_file):
    """
    Iterate through the pb (page-beginning) elements of the text. When a
    non-empty @n value is found, the counter is updated, incremented by one, and
    inserted in the next empty @n. When a new value is encountered, the counter
    starts from this, and so forth.

    """
    ET.register_namespace('', 'http://www.tei-c.org/ns/1.0')
    tree = ET.parse(xml_file)
    root = tree.getroot()

    counter = None

    for pb_element in root.findall(".//tei:pb", namespaces={'tei': 'http://www.tei-c.org/ns/1.0'}):
        n_value = pb_element.get("n")

        # Check if n_value is not empty
        if n_value:
            # Update counter with current n_value
            counter = int(n_value)
        elif counter is not None:
            # If n_value is empty and counter is not None, increment counter and set new value
            counter += 1
            pb_element.set("n", str(counter))

    # Save the modified XML
    output_filename = os.path.splitext(xml_file)[0] + "_pb_numbers.xml"
    tree.write(output_filename, encoding="utf-8", xml_declaration=True)

    #tree.write("output.xml")

def process_file(xml_file):
    """
    Process and XML file
    """
    if not os.path.isfile(xml_file) or not xml_file.lower().endswith(".xml"):
        print(f"Warning: Skipping '{xml_file}' (not a valid XML file).")
        return
    process_pb_elements(xml_file)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: pb-insert-numbers.py <file1> [<file2> ...]")
        sys.exit(1)

    for xml_filename in sys.argv[1:]:
        process_file(xml_filename)

        #if os.path.isfile(xml_filename) and xml_filename.lower().endswith(".xml"):
        #    process_pb_elements(xml_filename)
