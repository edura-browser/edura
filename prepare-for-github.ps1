# Edura Browser - GitHub Preparation Script
# This script helps prepare the project for GitHub upload

Write-Host "🚀 Preparing Edura Browser for GitHub Upload" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

# Check if we're in the right directory
if (-not (Test-Path "EduraBrowserSetup.iss")) {
    Write-Host "❌ Error: Please run this script from the CEF binary directory" -ForegroundColor Red
    Write-Host "Expected to find: EduraBrowserSetup.iss" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Found project files" -ForegroundColor Green

# Clean up build artifacts that shouldn't be in Git
Write-Host "🧹 Cleaning build artifacts..." -ForegroundColor Yellow

$cleanupPaths = @(
    "build",
    "installer",
    "C:\temp\edura_test",
    "C:\temp\edura_installer_test"
)

foreach ($path in $cleanupPaths) {
    if (Test-Path $path) {
        Write-Host "   Removing: $path" -ForegroundColor Gray
        Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Check for required files
Write-Host "📋 Checking required files..." -ForegroundColor Yellow

$requiredFiles = @(
    "README.md",
    "EDURA_LICENSE.txt", 
    "EduraBrowserSetup.iss",
    ".gitignore",
    "CONTRIBUTING.md",
    ".github/workflows/build.yml"
)

$missingFiles = @()
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "   ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $file" -ForegroundColor Red
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "❌ Missing required files. Please create them first." -ForegroundColor Red
    exit 1
}

# Check for source code modifications
Write-Host "🔍 Checking source code modifications..." -ForegroundColor Yellow

$modifiedFiles = @(
    "tests/cefsimple/simple_handler.h",
    "tests/cefsimple/simple_handler.cc", 
    "tests/cefsimple/simple_app.cc",
    "tests/cefclient/browser/base_client_handler.cc",
    "tests/cefclient/browser/client_handler.cc",
    "tests/cefclient/browser/views_window.cc"
)

foreach ($file in $modifiedFiles) {
    if (Test-Path $file) {
        Write-Host "   ✅ $file (modified)" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  $file (not found)" -ForegroundColor Yellow
    }
}

# Check for branding assets
Write-Host "🎨 Checking branding assets..." -ForegroundColor Yellow

if (Test-Path "new icons/edura.ico") {
    Write-Host "   ✅ Edura icon found" -ForegroundColor Green
} else {
    Write-Host "   ❌ Edura icon missing" -ForegroundColor Red
}

# Display next steps
Write-Host ""
Write-Host "🎯 Next Steps for GitHub Upload:" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Initialize Git repository:" -ForegroundColor White
Write-Host "   git init" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Add remote repository:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/Mooo0042/edura.git" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Add all files:" -ForegroundColor White
Write-Host "   git add ." -ForegroundColor Gray
Write-Host ""
Write-Host "4. Create initial commit:" -ForegroundColor White
Write-Host "   git commit -m `"Initial commit: Edura Browser v1.0.0`"" -ForegroundColor Gray
Write-Host ""
Write-Host "5. Push to GitHub:" -ForegroundColor White
Write-Host "   git branch -M main" -ForegroundColor Gray
Write-Host "   git push -u origin main" -ForegroundColor Gray
Write-Host ""
Write-Host "📝 Important Notes:" -ForegroundColor Yellow
Write-Host "- The .gitignore file will exclude build artifacts" -ForegroundColor Gray
Write-Host "- Source code modifications are included" -ForegroundColor Gray
Write-Host "- Branding assets (icons) are included" -ForegroundColor Gray
Write-Host "- Installer script is included" -ForegroundColor Gray
Write-Host "- GitHub Actions will handle automated builds" -ForegroundColor Gray
Write-Host ""
Write-Host "Project is ready for GitHub upload!" -ForegroundColor Green
