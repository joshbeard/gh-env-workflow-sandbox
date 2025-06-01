# GitHub Actions Workflow Test - Minimal

A minimal GitHub Actions workflow system for testing PR comment automation, security controls, and argument passing. **Purpose: Test workflow mechanisms, not build anything complex.**

## What This Tests

- 🔍 **Comment parsing**: Extract commands and arguments from PR comments
- 🔒 **Security**: Protected environment with manual approval
- ⚙️ **Arguments**: Pass custom parameters between workflow jobs
- 🎯 **Events**: Different triggers (comment, PR close, manual)
- 🔐 **Secrets**: Environment-level secret access
- 🧹 **Cleanup**: Auto-cleanup on PR close

## Setup

1. **Create environment**: Go to Settings > Environments, create `preview-pr` with manual approval
2. **Add secret**: `ENVIRONMENT_SECRET` with any test value (e.g., "test-secret-123")

## Test Commands

Use these in PR comments:

```bash
/demo                            # Basic test
/demo --env staging --debug      # Test custom arguments
/demo --foo bar --flag           # Test multiple arguments
/demo cleanup                    # Test manual cleanup
```

## Files

- **`.github/workflows/preview.yml`** - The workflow (this is what we're testing!)
- **`demo/generate-demo.sh`** - Minimal script that echoes back what it receives

## Local Testing

```bash
# Test the script directly
cd demo
./generate-demo.sh --test

# Test with arguments
./generate-demo.sh --output test --env prod --title "A quoted arg" --debug
```

## What You'll See

When you trigger the workflow, the logs will show:
- Comment parsing and argument extraction
- User permission validation
- Environment context (repo, commit, etc.)
- Secret availability (without exposing values)
- Argument processing
- Artifact generation

## Workflow Flow

```
1. PR Comment (/demo --args)
2. Security check (manual approval required)
3. Script execution (with secrets and parsed args)
4. Results posted to PR
5. Cleanup when PR closes
```

This demonstrates the complete GitHub Actions pattern for PR-based automation while keeping the actual work minimal so you can focus on the **workflow mechanics**.