"""Check current federal DotGov domains for a Vulnerability Disclosure Policy.

Usage:
    vdp-scanner.py [options]

Options:
    -h, --help                   Show this help message.
    -v, --version                Show script version.
    -s, --source-csv=SOURCE_CSV  CSV to use as a source of domains.
    -a, --agency-csv=AGENCY_CSV  Filename to use for Agency results.
    -d, --domain-csv=DOMAIN_CSV  Filename to use for Domain results.
"""

# Standard Python Libraries
import logging
from typing import Any, Dict

# Third-Party Libraries
import docopt


def get_version(version_file):
    """Extract a version number from the given file path."""
    with open(version_file) as vfile:
        for line in vfile.read().splitlines():
            if line.startswith("__version__"):
                delim = '"' if '"' in line else "'"
                return line.split(delim)[1]

    raise RuntimeError("Unable to find version string.")


def main():
    """Scan hosts with the hash-http-content package and output results."""
    logging.basicConfig(
        format="%(asctime)-15s %(levelname)s %(message)s", level=logging.INFO
    )

    __version__: str = get_version("version.txt")
    args: Dict[str, Any] = docopt.docopt(__doc__, version=__version__)

    logging.info(args)


if __name__ == "__main__":
    main()
