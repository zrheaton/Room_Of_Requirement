#!/bin/bash

# Navigate to repository directory
cd C:\Users\17206\Documents\GitHub\Room_Of_Requirement

# Get user input for commit message
echo "Any notes about this update?"
read commit_message

# Perform Git operations
git status
git add .
git commit -m "$commit_message"
git push origin main

# Define the file path for the output file
# Update the path format if you're using a POSIX-style path on Windows
output_folder="/c/Users/17206/Desktop/GitHubUpdateNoteFolder"
output_file="$output_folder/GitHubUpdate$(date '+%m%d%Y%H%M').txt"

# Save the output of the Git operations
{
    echo "Git Update on $(date)"
    echo "Commit Message: $commit_message"
    echo ""
    git status
} > "$output_file"

echo "Update complete. Details saved in $output_file"
