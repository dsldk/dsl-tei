I mappen <https://github.com/dsldk/dsl-tei/tree/master/xslt> findes
XSLT-stilark til transformation af dokumenter, der validerer med
dsl-tei.rnc.

# Forudsætninger

# Installation

## Linux

	$ apt-get update && apt-get install saxon
 
## Mac OSX

Installer Homebrew:

	$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Opdater pakkelisten

	$ brew update

Installér saxon

	$ brew install saxon
	

# Fremgangsmåde

	$ saxon -o /html/test.html /xml/14021010001.xml /xslt/main.xsl


