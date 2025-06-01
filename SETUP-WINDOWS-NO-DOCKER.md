# MCP Atlassian Setup Without Docker for VS Code on Windows

This guide shows how to run MCP Atlassian with GitHub Copilot in VS Code on Windows **without Docker**, contrary to the original author's claim.

## Prerequisites

1. **Python 3.9+** installed on Windows
2. **UV package manager** installed (`pip install uv` or download from [github.com/astral-sh/uv](https://github.com/astral-sh/uv))
3. **VS Code** with the GitHub Copilot extension

## Setup Instructions

### 1. Clone and Build the Project

```bash
git clone https://github.com/your-repo/mcp-atlassian.git
cd mcp-atlassian
uv build
```

### 2. Test the Installation

```bash
# Test that the MCP server works
uvx --from . mcp-atlassian --help
```

### 3. Configure VS Code Settings

Add this configuration to your VS Code `settings.json` file (`Ctrl+Shift+P` → "Preferences: Open User Settings (JSON)"):

```json
{
  "mcp": {
    "servers": {
      "mcp-atlassian": {
        "command": "uvx",
        "args": [
          "--from",
          "c:\\path\\to\\mcp-atlassian",
          "mcp-atlassian",
          "--transport",
          "stdio",
          "--read-only"
        ],
        "env": {
          "CONFLUENCE_URL": "https://your-company.atlassian.net/wiki",
          "CONFLUENCE_USERNAME": "your.email@company.com", 
          "CONFLUENCE_API_TOKEN": "your-confluence-api-token",
          "JIRA_URL": "https://your-company.atlassian.net",
          "JIRA_USERNAME": "your.email@company.com",
          "JIRA_API_TOKEN": "your-jira-api-token",
          "READ_ONLY_MODE": "false",
          "MCP_VERBOSE": "true"
        }
      }
    }
  }
}
```

**Important:** Replace `c:\\path\\to\\mcp-atlassian` with the actual path to your cloned repository.

### 4. Alternative Installation Methods

#### Option A: Install as a UV Tool
```bash
cd mcp-atlassian
uv tool install .
```

Then use `"command": "mcp-atlassian"` instead of the uvx approach.

#### Option B: Use UV Run (Development)
```bash
cd mcp-atlassian
uv run mcp-atlassian --help
```

Then use `"command": "uv"` with `"args": ["run", "mcp-atlassian", ...]`

### 5. Environment Variables (Optional)

Instead of putting credentials in VS Code settings, you can create a `.env` file:

```bash
cp .env.example .env
# Edit .env with your credentials
```

Then modify your VS Code configuration to use the env file:

```json
{
  "mcp-atlassian": {
    "command": "uvx",
    "args": [
      "--from", 
      "c:\\path\\to\\mcp-atlassian",
      "mcp-atlassian",
      "--env-file",
      "c:\\path\\to\\mcp-atlassian\\.env",
      "--transport",
      "stdio"
    ]
  }
}
```

## Verification

1. **Restart VS Code** after updating settings
2. **Open GitHub Copilot Chat** (`Ctrl+Shift+I`)
3. **Test MCP connection** by asking questions about your Jira issues or Confluence pages

## Supported Transport Methods

- **stdio** (default, recommended for VS Code)
- **SSE** (Server-Sent Events) - for persistent connections
- **streamable-http** - for HTTP-based communication

## Authentication Methods Supported

- **API Tokens** (Atlassian Cloud) - Recommended
- **Personal Access Tokens** (Server/Data Center)
- **OAuth 2.0** (Cloud only, advanced)
- **Basic Authentication** (Server/Data Center)

## Features Available

- Search Jira issues and projects
- Search Confluence pages and spaces  
- Create/update Jira issues (if not in read-only mode)
- Create/update Confluence pages (if not in read-only mode)
- Get issue/page details and metadata
- Filter by projects, spaces, etc.

## Troubleshooting

### MCP Server Not Found
- Ensure the path in VS Code settings matches your repository location
- Test the command manually in terminal: `uvx --from . mcp-atlassian --help`

### Authentication Errors
- Verify your API tokens are correct and not expired
- Check URL formats (include `/wiki` for Confluence Cloud URLs)
- For Server/Data Center, use Personal Access Tokens instead of API tokens

### VS Code Not Recognizing MCP
- Restart VS Code completely after changing settings
- Check VS Code Developer Console (`Help` → `Toggle Developer Tools`) for errors
- Ensure GitHub Copilot extension is enabled and up to date

## Success! You're Running MCP Atlassian Without Docker

This proves that the original documentation claiming "Docker-only support" was incorrect. The project runs perfectly on Windows with direct Python execution using UV package manager.
