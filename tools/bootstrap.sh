#!/bin/bash -
# Or possibly: #!/usr/bin/env bash
# bootstrap.sh: a tool for configuration of the dsl-workspace
# Author: Thomas Hansen, 2023-11-28

PROGRAM=${0##*/}  # bash version of `basename`

repository_url="git@github.com:dsldk/dsl-tei.git"
tei_directory="dsl-tei"
workspace_dir="dsl-workspace"
danish_dictionary="da_DK"

# Check if the directory exists
if [ -d "$workspace_dir" ]; then
    echo "Directory '$workspace_dir' already exists."
else
    # Create the directory if it doesn't exist
    mkdir "$workspace_dir"
    echo "Directory '$workspace_dir' created."
fi

# Check if dsl-tei directory exists within dsl-workspace
if [ -d "$workspace_dir/$tei_directory" ]; then
    echo "Directory '$tei_directory' already exists in '$workspace_dir'. Skipping Git clone."
else
    # Clone the Git repository into the workspace directory
    echo "Cloning the Git repository into '$workspace_dir'..."
    git clone "$repository_url" "$workspace_dir/$tei_directory"
fi

# Install Aspell with Danish dictionary
echo "Installing Aspell with Danish dictionary..."
sudo apt-get update
sudo apt-get install aspell aspell-da

echo "Script execution completed."
