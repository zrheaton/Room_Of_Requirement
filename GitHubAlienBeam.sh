#This script is a great tool to simplify updates to your repository. 
#You will need two directories. 1) The Local GitHub Repository and 2) A directory for output notes (you will have to create). 
#Insert your respective file paths and watch the magic! 

#!/bin/bash

# Navigate to repository directory
cd C:\Users\17206\Documents\GitHub\Room_Of_Requirement

# Get user input for commit message
echo "Any notes about this update?"
read commit_message

# Perform Git operations and capture their outputs
status_output=$(git status)
diff_output=$(git diff --cached)  # Shows changes that have been staged

git add .

commit_output=$(git commit -m "$commit_message")
push_output=$(git push origin main)

# Define the file path for the output file
# Update the path format if you're using a POSIX-style path on Windows
output_folder="/c/Users/17206/Desktop/GitHubUpdateNoteFolder"
output_file="$output_folder/GitHubUpdate$(date '+%m%d%Y%H%M').txt"

# Save the output of the Git operations
{
    echo "Git Update on $(date)"
    echo "Commit Message: $commit_message"
    echo ""
    echo "Git Status Before Commit:"
    echo "$status_output"
    echo ""
    echo "Git Diff (Staged Changes):"
    echo "$diff_output"
    echo ""
    echo "Commit Output:"
    echo "$commit_output"
    echo ""
    echo "Push Output:"
    echo "$push_output"
} > "$output_file"

echo "Update complete. Details saved in $output_file"
