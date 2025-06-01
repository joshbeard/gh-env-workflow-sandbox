#!/bin/bash

# Minimal GitHub Actions Workflow Test Script
# Purpose: Test workflow mechanisms (secrets, args, environment)

set -e

echo "🔧 GitHub Actions Workflow Test"
echo "==============================="
echo ""

# Show all arguments received
echo "📝 All arguments received:"
for i in "$@"; do
    echo "  - '$i'"
done
echo ""

# Show key environment variables
echo "🌍 Environment variables:"
echo "  - GITHUB_ACTOR: ${GITHUB_ACTOR:-'(not set)'}"
echo "  - GITHUB_REPOSITORY: ${GITHUB_REPOSITORY:-'(not set)'}"
echo "  - GITHUB_SHA: ${GITHUB_SHA:-'(not set)'}"
echo "  - GITHUB_REF: ${GITHUB_REF:-'(not set)'}"
echo "  - GITHUB_EVENT_NAME: ${GITHUB_EVENT_NAME:-'(not set)'}"
echo "  - PR_NUMBER: ${PR_NUMBER:-'(not set)'}"
echo ""

# Test secret access (without exposing values)
echo "🔐 Secret access test:"
if [[ -n "${ENVIRONMENT_SECRET:-}" ]]; then
    echo "  ✅ ENVIRONMENT_SECRET is available (length: ${#ENVIRONMENT_SECRET})"
else
    echo "  ❌ ENVIRONMENT_SECRET not available"
fi
echo ""

# Parse arguments to demonstrate workflow parsing
echo "🎯 Argument parsing test:"
output_dir="output"
extra_args=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --output)
            output_dir="$2"
            echo "  - Output directory: $2"
            shift 2
            ;;
        --test)
            echo "  ✅ Test mode flag detected"
            echo ""
            echo "🎉 All workflow mechanisms working!"
            exit 0
            ;;
        *)
            extra_args+=("$1")
            echo "  - Extra arg: $1"
            shift
            ;;
    esac
done

if [[ ${#extra_args[@]} -gt 0 ]]; then
    echo "  - Unparsed args: ${extra_args[*]}"
fi
echo ""

# Create simple output to show script ran
mkdir -p "$output_dir"
cat > "$output_dir/workflow-test.txt" << EOF
GitHub Actions Workflow Test Results
===================================
Timestamp: $(date)
Arguments: $*
Environment: ${GITHUB_EVENT_NAME:-local}
Repository: ${GITHUB_REPOSITORY:-local}
Actor: ${GITHUB_ACTOR:-local}
SHA: ${GITHUB_SHA:-local}
PR: ${PR_NUMBER:-local}
Secret Available: ENVIRONMENT_SECRET=${ENVIRONMENT_SECRET:+yes}
EOF

echo "📁 Created test output: $output_dir/workflow-test.txt"
echo ""
echo "✅ Workflow test script completed successfully!"
echo "   This proves the GitHub Actions workflow is working correctly."