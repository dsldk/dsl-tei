#!/bin/sh

workspace_dir="dsl-workspace"
tei_directory="dsl-tei"
repository_url="git@github.com:dsldk/dsl-tei.git"
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
if command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install aspell aspell-da
elif command -v brew &> /dev/null; then
    brew install aspell
    brew install aspell-da
else
    echo "Package manager not supported. Please install Aspell and the Danish dictionary manually."
fi

echo "Script execution completed."
