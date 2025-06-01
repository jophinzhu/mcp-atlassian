# MCP Atlassian Distribution Guide

## Quick Installation for Users

Once published, users can install your MCP Atlassian package with:

```bash
pip install mcp-atlassian
```

## Distribution Methods

### 1. PyPI (Python Package Index) - RECOMMENDED

**Benefits:**
- Users can install with `pip install mcp-atlassian`
- Automatic dependency management
- Version management
- Wide ecosystem compatibility

**Setup Steps:**

1. **Create PyPI Account:**
   - Go to https://pypi.org and create an account
   - Verify your email address

2. **Generate API Token:**
   - Go to https://pypi.org/manage/account/
   - Scroll to "API tokens" section
   - Click "Add API token"
   - Name: "mcp-atlassian-upload"
   - Scope: "Entire account" (or create project-specific after first upload)
   - Copy the token (starts with `pypi-`)

3. **Upload to PyPI:**
   ```bash
   # Clean build
   uv build
   
   # Upload to PyPI (you'll be prompted for username and password)
   # Username: __token__
   # Password: your-api-token-here
   twine upload dist/*
   ```

4. **Alternative: Store token in keyring**
   ```bash
   # Store token securely
   python -c "import keyring; keyring.set_password('https://upload.pypi.org/legacy/', '__token__', 'your-token-here')"
   
   # Then upload without prompts
   twine upload dist/*
   ```

### 2. GitHub Releases with Attachments

**Benefits:**
- Direct download of wheel files
- No PyPI account needed
- Release notes and changelogs

**Setup:**
Your GitHub workflow is already configured! Just:
1. Create a GitHub release at https://github.com/jophinzhu/mcp-atlassian/releases
2. Tag: `v0.1.0`
3. The workflow will automatically build and attach the packages

**Users can install from GitHub release:**
```bash
pip install https://github.com/jophinzhu/mcp-atlassian/releases/download/v0.1.0/mcp_atlassian-0.1.0-py3-none-any.whl
```

### 3. Docker Container (Already Configured)

**Benefits:**
- Containerized environment
- Easy deployment
- Cross-platform compatibility

**Your Docker workflow publishes to GitHub Container Registry:**
```bash
docker pull ghcr.io/jophinzhu/mcp-atlassian:latest
```

### 4. Direct Source Installation

**For developers who want the latest code:**
```bash
pip install git+https://github.com/jophinzhu/mcp-atlassian.git
```

## Recommended Next Steps

1. **Upload to PyPI** (most user-friendly)
2. **Create GitHub Release** (for backup distribution)
3. **Update README.md** with installation instructions
4. **Announce** your package to the MCP community

## User Installation Instructions

Add this to your README.md:

```markdown
## Installation

Install the latest release from PyPI:

```bash
pip install mcp-atlassian
```

Or install the development version from GitHub:

```bash
pip install git+https://github.com/jophinzhu/mcp-atlassian.git
```

### For MCP Configuration

After installation, add to your MCP settings:

```json
{
  "mcpServers": {
    "atlassian": {
      "command": "mcp-atlassian",
      "args": [],
      "env": {
        "ATLASSIAN_URL": "your-instance.atlassian.net",
        "ATLASSIAN_USERNAME": "your-email@domain.com",
        "ATLASSIAN_API_TOKEN": "your-api-token"
      }
    }
  }
}
```
```

## Automation Already Set Up

Your project already has:
- ✅ GitHub Actions for PyPI publishing
- ✅ GitHub Actions for Docker publishing  
- ✅ Proper package metadata
- ✅ Professional README
- ✅ Version management with tags

Just need to add PyPI credentials and create releases!
