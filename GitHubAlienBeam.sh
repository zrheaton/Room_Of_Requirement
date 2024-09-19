#!/bin/bash

# Define constants for your paths
REPO_DIR="/c/Users/zrhea/OneDrive/Desktop/Projects/GithubLocal"
BACKUP_PARENT_DIR="/c/Users/zrhea/OneDrive/Desktop/Projects/GitHubPulls"
TIMESTAMP=$(date '+%Y%m%d%H%M')
PULL_DIR="$BACKUP_PARENT_DIR/GitHubPull_$TIMESTAMP"
LOG_DIR="/c/Users/zrhea/OneDrive/Desktop/Projects/GitHubPulls/UpdateLogs"

# Step 1: Create a new directory to pull the latest version from GitHub
mkdir -p "$PULL_DIR" || {
    echo "Failed to create directory: $PULL_DIR"
    exit 1
}

# Step 2: Clone the remote GitHub repository into the new directory
echo "Cloning the remote repository into: $PULL_DIR"
git clone https://github.com/zrheaton/zackheatonportfolio "$PULL_DIR"

# Step 3: Run a diff between the local repo and the latest pull directory
echo "Running a diff between the local repo ($REPO_DIR) and the pulled repo ($PULL_DIR)..."
diff_output=$(diff -r "$REPO_DIR" "$PULL_DIR")

if [ -n "$diff_output" ]; then
    echo "Differences found between the local and pulled version:"
    echo "$diff_output"

    # Log the diff output in a log file
    output_file="$LOG_DIR/GitHubDiff_$TIMESTAMP.txt"
    echo "$diff_output" > "$output_file"
    echo "Diff results saved in $output_file"
else
    echo "No differences found between the local and pulled version."
fi

# Step 4: Check for changes in the local repository
status_output=$(git -C "$REPO_DIR" status --porcelain)

# Step 5: If there are local changes, prompt the user to commit and push them
if [ -n "$status_output" ]; then
    echo "The following changes have been detected locally:"
    git -C "$REPO_DIR" status -s

    echo "Would you like to commit these changes? (y/n)"
    read -r confirm_commit

    if [ "$confirm_commit" = "y" ]; then
        echo "Would you like to add notes to the log for these changes? (y/n)"
        read -r add_notes

        if [ "$add_notes" = "y" ]; then
            echo "Please enter your notes:"
            read -r commit_message
        else
            commit_message="No additional notes provided."
        fi

        # Stage and commit the changes
        git -C "$REPO_DIR" add .
        git -C "$REPO_DIR" commit -m "$commit_message"
        
        # Push the changes to the remote repository
        git -C "$REPO_DIR" push origin main
        echo "Local changes successfully pushed to the repository."
    else
        echo "Local changes were not committed."
    fi
else
    echo "No local changes detected."
fi
