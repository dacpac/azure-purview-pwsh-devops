<# Get Public and Private function definition files. #>
Write-Verbose 'Importing Functions...'

# Import everything in these folders
foreach ($folder in @('Private', 'Public')) {
    $root = Join-Path -Path $PSScriptRoot -ChildPath $folder

    if (Test-Path -Path $root) {
        Write-Verbose "Processing folder $($root)"
        $files = Get-ChildItem -Path $root -Filter '*.ps1'
        # dot source each file
        $files | 
        Where-Object { $_.Name -notlike '*.Tests.ps1' } | 
        ForEach-Object { 
            Write-Verbose $_.Name 
            . $_.FullName 
        }          
    }
}
