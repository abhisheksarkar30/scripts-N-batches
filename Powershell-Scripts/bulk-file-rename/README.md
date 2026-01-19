# Basic usage
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder"

# Preview changes
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder" -WhatIf

# Process all subfolders
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder" -Recursive

# Preserve file extensions
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder" -IncludeExtensions
