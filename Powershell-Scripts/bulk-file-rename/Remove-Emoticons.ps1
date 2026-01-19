# Remove emoticons and non-standard characters from all file names in a directory

param(
    [Parameter(Mandatory=$true)]
    [string]$DirectoryPath,
    
    [switch]$WhatIf,
    [switch]$Recursive,
    [switch]$IncludeExtensions
)

# Function to sanitize file names
function Sanitize-FileName {
    param([string]$FileName)
    
    # Extract extension if preserving it
    if ($IncludeExtensions) {
        $extension = [System.IO.Path]::GetExtension($FileName)
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    } else {
        $baseName = $FileName
        $extension = ""
    }
    
    # Define allowed characters:
    # - Alphabetic (A-Z, a-z)
    # - Digits (0-9)
    # - Common special characters: space, hyphen, underscore, period, parentheses, brackets, etc.
    # Using a more explicit approach with character classes
    $allowedPattern = '[^\p{L}\p{Nd}\s\-_\.\(\)\[\]\{\},;!@#\$%\^&\*\+=\~`''"" ]'
    
    # Remove non-allowed characters
    $sanitizedName = $baseName -replace $allowedPattern, ''
    
    # Remove multiple consecutive spaces and trim
    $sanitizedName = $sanitizedName -replace '\s+', ' '
    $sanitizedName = $sanitizedName.Trim()
    
    # Combine with extension
    if ($IncludeExtensions) {
        return $sanitizedName + $extension
    } else {
        return $sanitizedName
    }
}

# Main script
try {
    # Validate directory exists
    if (-not (Test-Path -Path $DirectoryPath -PathType Container)) {
        Write-Error "Directory not found: $DirectoryPath"
        exit 1
    }
    
    # Get files based on recursive flag
    if ($Recursive) {
        $files = Get-ChildItem -Path $DirectoryPath -File -Recurse
    } else {
        $files = Get-ChildItem -Path $DirectoryPath -File
    }
    
    $processedCount = 0
    $skippedCount = 0
    
    foreach ($file in $files) {
        $oldName = $file.Name
        $newName = Sanitize-FileName -FileName $oldName
        
        # Skip if name hasn't changed
        if ($oldName -eq $newName) {
            $skippedCount++
            continue
        }
        
        # Ensure new name is not empty
        if ([string]::IsNullOrWhiteSpace($newName)) {
            Write-Warning "Sanitized name would be empty for: $oldName. Skipping."
            $skippedCount++
            continue
        }
        
        # Handle duplicate names
        $newFullPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
        $counter = 1
        while (Test-Path -Path $newFullPath) {
            if ($IncludeExtensions) {
                $baseName = [System.IO.Path]::GetFileNameWithoutExtension($newName)
                $extension = [System.IO.Path]::GetExtension($newName)
                $newName = "${baseName}_$counter$extension"
            } else {
                $newName = "${newName}_$counter"
            }
            $newFullPath = Join-Path -Path $file.DirectoryName -ChildPath $newName
            $counter++
        }
        
        # Rename the file
        if ($WhatIf) {
            Write-Host "WhatIf: Would rename '$oldName' to '$newName'" -ForegroundColor Yellow
        } else {
            try {
                Rename-Item -Path $file.FullName -NewName $newName -Force
                Write-Host "Renamed: '$oldName' -> '$newName'" -ForegroundColor Green
                $processedCount++
            } catch {
                Write-Error "Failed to rename '$oldName': $_"
            }
        }
    }
    
    # Summary
    Write-Host "`n=== Summary ===" -ForegroundColor Cyan
    Write-Host "Processed files: $processedCount"
    Write-Host "Skipped files: $skippedCount"
    Write-Host "Total files: $($files.Count)"
    
    if ($WhatIf) {
        Write-Host "`nNote: Run without -WhatIf to actually rename files" -ForegroundColor Yellow
    }
    
} catch {
    Write-Error "An error occurred: $_"
}