#!/usr/bin/python3

"""
transform.py


"""

import sys
import os
from lxml import etree

def transform_to_html(xml_file, xsl_file, output_folder):
    try:
        # Load XML and XSL files
        xml_tree = etree.parse(xml_file)

        # Specify the path to the XML file relative to the script
        #directory_name = os.path.abspath(os.path.dirname(xml_file))

        # Specify the path to the XSL file relative to the script
        xsl_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "xsl", xsl_file))

        xsl_tree = etree.parse(xsl_file_path)

        # Create an XSLT transformer
        transform = etree.XSLT(xsl_tree)
        #transform = etree.XSLT(etree.parse(xsl_file_path), directoryName=etree.XSLT.strparam(directory_name))

        # Perform the transformation
        result_tree = transform(xml_tree)

        # Create the output filename by changing the extension to .html and specifying the output folder
        output_filename = os.path.join(output_folder, os.path.splitext(os.path.basename(xml_file))[0] + ".html")

        # Serialize the result as HTML and write to the output file
        with open(output_filename, "wb") as output_file:
            output_file.write(etree.tostring(result_tree, method="html", encoding="utf-8", pretty_print=True))

        print(f"Transformed '{xml_file}' to '{output_filename}'")

    except FileNotFoundError:
        print(f"Error: File '{xml_file}' not found.")
    except Exception as e:
        print(f"Error: An error occurred while processing '{xml_file}': {e}")

if __name__ == "__main__":
    # Check if at least one XML file is provided as an argument
    if len(sys.argv) < 2:
        print("Usage: python xslt_transform.py <filename1> [<filename2> ...]")
        sys.exit(1)

    # Specify the output folder
    output_folder = "html"

    # Create the output folder if it doesn't exist
    os.makedirs(output_folder, exist_ok=True)

    # Process each XML file provided as an argument
    for xml_filename in sys.argv[1:]:
        if os.path.isfile(xml_filename) and xml_filename.lower().endswith(".xml"):
            xsl_filename = "fulltext.xsl"  # The path is relative to the script
            transform_to_html(xml_filename, xsl_filename, output_folder)
        else:
            print(f"Warning: Skipping '{xml_filename}' (not a valid XML file).")
