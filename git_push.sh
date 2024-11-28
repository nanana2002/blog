#!/bin/bash

# Add the modified file
git add .

# Commit with message
git commit -m "docs: add notes"

# Push to remote repository
git push origin main

echo "Changes have been committed and pushed!"
