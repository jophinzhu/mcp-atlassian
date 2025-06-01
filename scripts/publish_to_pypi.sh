#!/bin/bash

# MCP Atlassian PyPI Upload Script
# This script uploads your package to PyPI

echo "🚀 Publishing MCP Atlassian to PyPI..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf dist/*

# Build the package
echo "🔨 Building package..."
uv build

# Check package validity
echo "✅ Checking package validity..."
twine check dist/*

if [ $? -ne 0 ]; then
    echo "❌ Package validation failed!"
    exit 1
fi

echo "📦 Ready to upload to PyPI!"
echo ""
echo "Your packages:"
ls -la dist/

echo ""
echo "To upload to PyPI, you have two options:"
echo ""
echo "1. Upload with username/password prompt:"
echo "   twine upload dist/*"
echo ""
echo "2. Upload with stored API token:"
echo "   First store your token:"
echo "   python -c \"import keyring; keyring.set_password('https://upload.pypi.org/legacy/', '__token__', 'your-pypi-token-here')\""
echo "   Then upload:"
echo "   twine upload dist/*"
echo ""
echo "🔗 After upload, users can install with:"
echo "   pip install mcp-atlassian"
