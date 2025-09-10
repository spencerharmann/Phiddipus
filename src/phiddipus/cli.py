# @author Spencer Harman
# @file cli.py
# Handles command line so it can be run on CLI

import sys
import asyncio

# Makes sure the code here only runs when this script is executed
def main():
    # libary cheeeeeck
    try:
        import httpx
        from bs4 import BeautifulSoup
    except ImportError:
        print( "Error: Required libraries not found." )
        sys.exit( 1 )

    from . import vulnerabilityScanner
    asyncio.run( vulnerabilityScanner.main() )
