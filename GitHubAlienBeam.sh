#!/bin/bash

# Define constants for your paths
REPO_DIR="/c/Users/zrhea/OneDrive/Desktop/Projects/GithubLocal"
LOG_DIR="/c/Users/zrhea/OneDrive/Desktop/Projects/GithubLocal/UpdateLogs"

# Navigate to the correct directory
cd "$REPO_DIR" || {
    echo "Directory not found: $REPO_DIR"
    exit 1
}

# Check for changes in the local repository
status_output=$(git status --porcelain)

# If there are changes, display them and ask for confirmation
if [ -n "$status_output" ]; then
    echo "The following changes have been detected:"
    git status -s  # Short output of changes
    echo ""
    
    # Ask user if they want to proceed with committing the changes
    echo "Would you like to commit these changes? (y/n)"
    read -r confirm_commit
    
    if [ "$confirm_commit" = "y" ]; then
        # Ask for commit notes if changes are confirmed
        echo "Would you like to add notes to the log for these changes? (y/n)"
        read -r add_notes
        
        if [ "$add_notes" = "y" ]; then
            echo "Please enter your notes:"
            read -r commit_message
        else
            commit_message="No additional notes provided."
        fi
        
        # Stage all changes
        git add .
        
        # Commit the changes with the provided message
        git commit -m "$commit_message"
        
        # Push the changes to the remote repository
        git push origin main

        echo "Changes successfully pushed to the repository."

        # Check if log directory exists, if not create it
        if [ ! -d "$LOG_DIR" ]; then
            mkdir -p "$LOG_DIR"
        fi

        # Log the details of the commit
        output_file="$LOG_DIR/GitHubUpdate$(date '+%Y%m%d%H%M').txt"
        
        {
            echo "Git Update on $(date)"
            echo ""
            echo "Commit Message: $commit_message"
            git log -1 --pretty=format:"%h - %s (%ci)"
        } > "$output_file"
        
        echo "Log saved at $output_file"
    else
        echo "Changes were not committed."
    fi
else
    echo "No changes detected in the repository."
fi
