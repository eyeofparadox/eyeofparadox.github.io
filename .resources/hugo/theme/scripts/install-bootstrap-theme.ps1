# ```

# install-bootstrap-theme.ps1
# Usage:
#   .\install-bootstrap-theme.ps1
#   .\install-bootstrap-theme.ps1 -SitePath "eyeofparadox.github.io"

param (
    [string]$SitePath = $null
)

# If no SitePath provided, default to current working directory
if (-not $SitePath) {
    $SitePath = (Get-Location).Path
}

Write-Host ">>> Using site path: $SitePath" -ForegroundColor Cyan

try {
    # Navigate into your site
    Set-Location $SitePath
    Write-Host ">>> Entered site directory." -ForegroundColor Green

    # Add the theme as a submodule (only if not already present)
    if (-not (Test-Path .\themes\hugo-theme-bootstrap)) {
        Write-Host ">>> Adding Bootstrap theme submodule..." -ForegroundColor Yellow
        git submodule add https://github.com/eyeofparadox/hugo-theme-bootstrap themes/hugo-theme-bootstrap
        Write-Host ">>> Theme submodule added." -ForegroundColor Green
    } else {
        Write-Host ">>> Theme submodule already exists, skipping." -ForegroundColor DarkYellow
    }

    # Clone the skeleton into a temp folder
    $SkeletonPath = Join-Path $env:TEMP "hbs-skeleton"
    Write-Host ">>> Cloning skeleton repo to $SkeletonPath..." -ForegroundColor Yellow
    git clone https://github.com/eyeofparadox/hugo-theme-bootstrap-skeleton $SkeletonPath
    Write-Host ">>> Skeleton cloned." -ForegroundColor Green

    # Ensure config directory exists
    New-Item -ItemType Directory -Force -Path .\config | Out-Null
    Write-Host ">>> Config directory ensured." -ForegroundColor Green

    # Copy skeleton files into your site
    Write-Host ">>> Copying skeleton files..." -ForegroundColor Yellow
    Copy-Item -Recurse -Force "$SkeletonPath\config\*" .\config
    Copy-Item -Recurse -Force "$SkeletonPath\content\*" .\content
    Copy-Item -Recurse -Force "$SkeletonPath\archetypes\*" .\archetypes
    Copy-Item -Recurse -Force "$SkeletonPath\static\*" .\static
    Copy-Item -Recurse -Force "$SkeletonPath\assets\*" .\assets
    Write-Host ">>> Skeleton files copied." -ForegroundColor Green

    # Update theme setting in config/_default/config.yaml
    Write-Host ">>> Updating theme in config/_default/config.yaml..." -ForegroundColor Yellow
    (Get-Content .\config\_default\config.yaml) `
      -replace 'theme:.*', 'theme: hugo-theme-bootstrap' |
      Set-Content .\config\_default\config.yaml
    Write-Host ">>> Theme updated." -ForegroundColor Green

    # Install npm dependencies
    Write-Host ">>> Running hugo mod npm pack..." -ForegroundColor Yellow
    hugo mod npm pack
    Write-Host ">>> Running npm install..." -ForegroundColor Yellow
    npm install
    Write-Host ">>> Dependencies installed." -ForegroundColor Green

    # Cleanup skeleton folder
    Write-Host ">>> Cleaning up skeleton folder..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $SkeletonPath
    Write-Host ">>> Skeleton folder removed." -ForegroundColor Green

    Write-Host ">>> Bootstrap theme installation complete." -ForegroundColor Cyan
}
catch {
    Write-Host "!!! ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}


# ```
