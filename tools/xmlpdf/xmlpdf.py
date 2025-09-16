import argparse
import subprocess
from pathlib import Path

# Paths to tools
SAXON = ["java", "-cp", "/usr/local/lib/saxon/saxon-he-11.6.jar", "net.sf.saxon.Transform"]
STYLESHEET = "/home/th/dev/tekstnet-xsl/fo/tekstnet-fo.xsl"

# Build classpath for FOP 2.11
FOP_HOME = Path("/opt/fop-2.11")
FOP_CP = f"{FOP_HOME}/fop/build/fop-2.11.jar:{FOP_HOME}/fop/lib/*"
FOP = ["java", "-cp", FOP_CP, "org.apache.fop.cli.Main"]


def process_file(xml_file: Path, root: Path, fo_dir: Path, pdf_dir: Path):
    """Transform a single XML file into FO and then PDF, preserving relative paths."""
    if xml_file.suffix != ".xml":
        return
    if xml_file.name.endswith(("_int.xml", "_acc.xml")):
        return

    rel_path = xml_file.relative_to(root).with_suffix("")  # relative path without .xml
    fo_file = fo_dir.joinpath(rel_path).with_suffix(".fo")
    pdf_file = pdf_dir.joinpath(rel_path).with_suffix(".pdf")

    # Ensure target directories exist
    fo_file.parent.mkdir(parents=True, exist_ok=True)
    pdf_file.parent.mkdir(parents=True, exist_ok=True)

    print(f"Processing {xml_file} → {pdf_file}")

    # Step 1: XML → FO
    subprocess.run(SAXON + [
        f"-s:{xml_file}", f"-xsl:{STYLESHEET}", f"-o:{fo_file}"
    ], check=True)

    # Step 2: FO → PDF
    subprocess.run(FOP + [str(fo_file), str(pdf_file)], check=True)


def main():
    parser = argparse.ArgumentParser(
        description="Transform XML files into PDF using Saxon + FOP"
    )
    parser.add_argument("path", type=Path, help="Path to XML file or directory")
    parser.add_argument("--fo-dir", type=Path, default=Path("fo"), help="Directory for FO output")
    parser.add_argument("--pdf-dir", type=Path, default=Path("pdf"), help="Directory for PDF output")
    args = parser.parse_args()

    if args.path.is_file():
        root = args.path.parent
        process_file(args.path, root, args.fo_dir, args.pdf_dir)
    elif args.path.is_dir():
        root = args.path
        for xml_file in root.rglob("*.xml"):
            process_file(xml_file, root, args.fo_dir, args.pdf_dir)
    else:
        print(f"Error: {args.path} is not a valid file or directory")


if __name__ == "__main__":
    main()
