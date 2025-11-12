#!/bin/bash

# Netlify Setup Verification Script
# Run this before deploying to verify everything is configured correctly

# Change to script directory
cd "$(dirname "$0")"

echo "🔍 Verifying Netlify Setup..."
echo "📁 Working directory: $(pwd)"
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
PASS=0
FAIL=0
WARN=0

# Check function
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 exists"
        ((PASS++))
        return 0
    else
        echo -e "${RED}✗${NC} $1 missing"
        ((FAIL++))
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 exists"
        ((PASS++))
        return 0
    else
        echo -e "${RED}✗${NC} $1 missing"
        ((FAIL++))
        return 1
    fi
}

check_not_exists() {
    if [ ! -e "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 removed (good)"
        ((PASS++))
        return 0
    else
        echo -e "${YELLOW}⚠${NC} $1 still exists (should be removed)"
        ((WARN++))
        return 1
    fi
}

check_content() {
    if grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $1 contains '$2'"
        ((PASS++))
        return 0
    else
        echo -e "${RED}✗${NC} $1 missing '$2'"
        ((FAIL++))
        return 1
    fi
}

echo "📋 Checking Required Files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Core configuration (at repo root)
check_file "../netlify.toml"
check_file "../.gitignore"
check_file "../.netlifyignore"

echo ""
echo "🐍 Checking Backend Files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_dir "backend/netlify/functions"
check_file "backend/netlify/functions/api.py"
check_file "backend/requirements.txt"
check_file "backend/runtime.txt"
check_file "backend/.env.example"

echo ""
echo "⚛️  Checking Frontend Files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_dir "frontend/src"
check_file "frontend/package.json"
check_file "frontend/vite.config.js"
check_file "frontend/.env.example"
check_file "frontend/.env.production"

echo ""
echo "📚 Checking Documentation..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_file "README.md"
check_file "QUICKSTART.md"
check_file "DEPLOY_NETLIFY.md"
check_file "DEPLOYMENT_CHECKLIST.md"

echo ""
echo "🗑️  Checking Vercel Files Removed..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_not_exists "backend/vercel.json"
check_not_exists "frontend/vercel.json"
check_not_exists "backend/.vercelignore"
check_not_exists "frontend/.vercelignore"
check_not_exists "DEPLOY_NOW.md"

echo ""
echo "🔧 Checking Configuration Content..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_content "../netlify.toml" "base = \"new-project/frontend\""
check_content "../netlify.toml" "functions = \"new-project/backend/netlify/functions\""
check_content "backend/requirements.txt" "mangum"
check_content "backend/runtime.txt" "3.9"

echo ""
echo "📦 Checking Dependencies..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if npm is installed
if command -v npm &> /dev/null; then
    echo -e "${GREEN}✓${NC} npm is installed"
    ((PASS++))
else
    echo -e "${RED}✗${NC} npm not found (needed for frontend)"
    ((FAIL++))
fi

# Check if python3 is installed
if command -v python3 &> /dev/null; then
    echo -e "${GREEN}✓${NC} python3 is installed"
    ((PASS++))
else
    echo -e "${RED}✗${NC} python3 not found (needed for backend)"
    ((FAIL++))
fi

# Check if pip is installed
if command -v pip3 &> /dev/null || command -v pip &> /dev/null; then
    echo -e "${GREEN}✓${NC} pip is installed"
    ((PASS++))
else
    echo -e "${RED}✗${NC} pip not found (needed for backend)"
    ((FAIL++))
fi

echo ""
echo "🔐 Checking Environment Variables..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f "backend/.env" ]; then
    if grep -q "GROQ_API_KEY" "backend/.env"; then
        echo -e "${GREEN}✓${NC} GROQ_API_KEY found in backend/.env (for local dev)"
        ((PASS++))
    else
        echo -e "${YELLOW}⚠${NC} GROQ_API_KEY not in backend/.env (needed for local dev)"
        ((WARN++))
    fi
else
    echo -e "${YELLOW}⚠${NC} backend/.env not found (create from .env.example for local dev)"
    ((WARN++))
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Verification Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✓ Passed:${NC} $PASS"
echo -e "${RED}✗ Failed:${NC} $FAIL"
echo -e "${YELLOW}⚠ Warnings:${NC} $WARN"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}🎉 All checks passed! Ready for Netlify deployment.${NC}"
    echo ""
    echo "Next steps:"
    echo "1. git add ."
    echo "2. git commit -m 'Ready for Netlify'"
    echo "3. git push origin main"
    echo "4. Follow QUICKSTART.md to deploy"
    exit 0
else
    echo -e "${RED}❌ Some checks failed. Please fix the issues above.${NC}"
    exit 1
fi
