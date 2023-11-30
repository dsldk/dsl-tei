#!/bin/sh

#-----------------------------------------------------------------#
# bootstrap.sh: Set-up a workspace and tools for editorial work   #
#               in Tekstnet. Tools include:                       #
#                  * prooflist.sh -- make a list of unknown words #
# Author:       Thomas Hansen, 2023-11-29                         #
#-----------------------------------------------------------------#

aspell_ods_dict="dsl-tei/tools/ods"

workspace_dir="dsl-workspace"
tei_dir="$workspace_dir/dsl-tei"
tei_tools_dir="$tei_dir/tools"
aspell_dict="$tei_tools_dir/ods"
aspell_dict_dir="/usr/lib/aspell"
executables_dir="/usr/local/bin"
prooflist="$tei_tools_dir/prooflist.sh"
repository_url="git@github.com:dsldk/dsl-tei.git"

# Install Aspell with Danish dictionary
echo "Installing Aspell with Danish dictionary..."
if command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install aspell aspell-da git
elif command -v brew &> /dev/null; then
    brew install aspell
    brew install aspell-da
    brew install git
else
    echo "Package manager not supported. Please install Aspell and the Danish dictionary manually."
fi

# Check if the directory exists
if [ -d "$workspace_dir" ]; then
    echo "Directory '$workspace_dir' already exists."
else
    # Create the directory if it doesn't exist
    mkdir "$workspace_dir"
    echo "Directory '$workspace_dir' created."
fi

# Check if dsl-tei directory exists within dsl-workspace
if [ -d "$tei_dir" ]; then
    echo "Directory '$tei_dir' already exists. Skipping Git clone."
else
    # Clone the Git repository into the workspace directory
    echo "Cloning the Git repository into '$workspace_dir'..."
    git clone "$repository_url" "$tei_dir"
fi


# Copy aspell dictionary to aspell's usual dict dir: /usr/lib/aspell
if [ -d "$aspell_dict_dir" ]; then 
    echo "Adding ODS dictionary to aspell dictionaries"
    sudo cp -- "$aspell_dict" "$aspell_dict_dir"
else
  echo "Aspell's dictionaries are not found at $aspell_dict_dir"
fi

# Copy Tekstnet tools to a directory in users PATH: /usr/local/bin
if [ -d "$executables_dir" ]; then
    echo "Copying files to $executables_dir"
    sudo cp -- "$prooflist" "$executables_dir"
fi
echo "Script execution completed."
