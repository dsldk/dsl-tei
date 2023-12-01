#!/usr/bin/python3

"""
transform.py

"""

import os
import sys
from lxml import etree

def transform_to_html(xml_file, xsl_script, output):
    """
    Transform the XML-file(s) using the fulltext.xsl 
    stylesheet and outputting an HTML-file.

    Parameters:
    - xml_file: the input file
    - xsl_script: XSLT script at dsl-workspace/dsl-tei/xsl/fulltext.xsl
    - output_dir: output dir at dsl-workspace/dsl-tei/home

    Returns: none

    Raises:
    -
    """
    try:
        # Load XML and XSL files
        xml_tree = etree.parse(xml_file)
        xsl_tree = etree.parse(xsl_script)
        # Create an XSLT transformer
        transform = etree.XSLT(xsl_tree)
        # Perform the transformation
        result_tree = transform(xml_tree)

        # Create the output filename by changing
        # extension to .html and specifying the output folder
        output_filename = os.path.join(
                output,
                os.path.splitext(os.path.basename(xml_file))[0] + ".html")

        # Serialize the result as HTML and write to the output file
        with open(output_filename, "wb") as output_file:
            output_file.write(
                    etree.tostring(
                        result_tree,
                        method="html",
                        encoding="utf-8",
                        pretty_print=True
                        )
                    )

        print(f"Transformed '{xml_file}' to '{output_filename}'")

    except FileNotFoundError:
        print(f"Error: File '{xml_file}' not found.")
    except Exception as e:
        print(f"Error: An error occurred while processing '{xml_file}': {e}")

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

if __name__ == "__main__":
    # Check if at least one XML file is provided as an argument
    if len(sys.argv) < 2:
        print("Usage: transform.py <file1> [<file2> ...]")
        sys.exit(1)

    # Process each XML file provided as argument
    for xml_filename in sys.argv[1:]:
        if os.path.isfile(xml_filename) and xml_filename.lower().endswith(".xml"):

            # Get the absolute path of the directory containing the XML file
            xml_dir = os.path.abspath(os.path.dirname(xml_filename))

            #Find dev dir
            dev_dir = find_dev_directory(xml_dir)
            # Construct the path to the XSLT script
            xslt_script = os.path.join(dev_dir, 'dsl-tei/xsl', 'fulltext.xsl')
            # Output dir
            output_dir = os.path.join(dev_dir, 'dsl-tei/html')
            # Transform
            transform_to_html(xml_filename, xslt_script, output_dir)
        else:
            print(f"Warning: Skipping '{xml_filename}' (not a valid XML file).")


    xml_filename = sys.argv[1]

    # Get the absolute path of the directory containing the XML file
    xml_dir = os.path.abspath(os.path.dirname(xml_filename))

    # Find the 'dev' directory
    dev_dir = find_dev_directory(xml_dir)

    if dev_dir:
        # Construct the path to the XSLT script
        xslt_script = os.path.join(dev_dir, 'dsl-tei/xsl', 'fulltext.xsl')
        output_dir = os.path.join(dev_dir, 'html')
    else:
        print("No 'dev' directory found.")
