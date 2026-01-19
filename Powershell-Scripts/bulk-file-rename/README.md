## Usage:

Save the script (preferably the simpler version) as `Remove-Emoticons.ps1` and run:

```powershell
# Basic usage
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder"

# Preview changes
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder" -WhatIf

# Process all subfolders
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder" -Recursive

# Preserve file extensions
.\Remove-Emoticons.ps1 -DirectoryPath "D:\YourFolder" -IncludeExtensions
```

The simpler version uses ASCII filtering which is more reliable and will remove all emoticons, emojis, and non-ASCII characters while keeping basic alphanumeric and common punctuation characters.
