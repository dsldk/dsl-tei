import sys
import os
from lxml import etree

def validate_and_pretty_print(filename):
    try:
        # Specify the XSD schema filename
        schema_filename = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "xsd", "dsl-tei.xsd"))

        # Check if the schema file exists
        if not os.path.isfile(schema_filename):
            print(f"Error: XSD schema file '{schema_filename}' not found.")
            return

        # Parse the XML file
        tree = etree.parse(filename)

        # Create an XSD validator
        xsd_validator = etree.XMLSchema(etree.parse(schema_filename))

        # Validate the XML against the XSD schema
        if xsd_validator.validate(tree):
            print(f"File: '{filename}' is valid according to the XSD schema.")
        else:
            print(f"File: '{filename}' is not valid according to the XSD schema.")

        # Serialize and pretty-print the XML with indentation and line breaks
        xml_str = etree.tostring(tree, pretty_print=True, encoding="utf-8")

        # Decode the XML to a string
        cleaned_xml_str = xml_str.decode("utf-8")

        # Remove blank lines
        cleaned_lines = [line for line in cleaned_xml_str.splitlines() if line.strip()]

        # Join the non-blank lines
        cleaned_xml_str = "\n".join(cleaned_lines)

        # Write the modified XML back to the same file
        with open(filename, "w", encoding="utf-8") as file:
            file.write(cleaned_xml_str)

        print(f"File: '{filename}' has been pretty-printed, had blank lines removed, and modified.")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
    except Exception as e:
        print(f"Error: An error occurred while processing '{filename}': {e}")

if __name__ == "__main__":
    # Check if at least one XML file is provided as an argument
    if len(sys.argv) < 2:
        print("Usage: python xml_pretty_printer_validator.py <filename1> [<filename2> ...]")
        sys.exit(1)

    # Process each XML file provided as an argument
    for filename in sys.argv[1:]:
        if os.path.isfile(filename) and filename.lower().endswith(".xml"):
            validate_and_pretty_print(filename)
        else:
            print(f"Warning: Skipping '{filename}' (not a valid XML file).")
