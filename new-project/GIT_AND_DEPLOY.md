# Git Setup and Deployment Guide

## 🔧 Git Repository Setup

### Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. Create a new repository (e.g., `ai-project-planner`)
3. **Do NOT** initialize with README, .gitignore, or license (you already have these)
4. Copy the repository URL (e.g., `https://github.com/yourusername/ai-project-planner.git`)

### Step 2: Add Remote and Push

```bash
# Add the remote repository
git remote add origin https://github.com/yourusername/ai-project-planner.git

# Verify the remote was added
git remote -v

# Push to GitHub
git push -u origin main
```

If you get an authentication error, you may need to:
- Use a Personal Access Token instead of password
- Or use SSH: `git remote set-url origin git@github.com:yourusername/ai-project-planner.git`

### Step 3: Verify on GitHub

Visit your repository URL to confirm all files are uploaded.

---

## 🚀 Deploy to Vercel

### Option 1: Deploy via Vercel Dashboard (Recommended)

#### Backend Deployment

1. Go to https://vercel.com/new
2. Click "Import Git Repository"
3. Select your GitHub repository
4. Configure:
   - **Project Name:** `ai-project-planner-backend`
   - **Framework Preset:** Other
   - **Root Directory:** `new-project/backend`
   - Leave other settings as default
5. Click "Deploy"
6. After deployment, go to **Settings → Environment Variables**
7. Add:
   ```
   GROQ_API_KEY = your_actual_groq_api_key
   ```
8. Select all environments (Production, Preview, Development)
9. Redeploy if needed

#### Frontend Deployment

1. Go to https://vercel.com/new again
2. Click "Import Git Repository"
3. Select the same GitHub repository
4. Configure:
   - **Project Name:** `ai-project-planner-frontend`
   - **Framework Preset:** Vite
   - **Root Directory:** `new-project/frontend`
   - **Build Command:** `npm run build`
   - **Output Directory:** `dist`
5. Click "Deploy"
6. After deployment, go to **Settings → Environment Variables**
7. Add:
   ```
   VITE_API_URL = https://your-backend-url.vercel.app
   ```
   (Replace with your actual backend URL from step 1)
8. Select all environments
9. Redeploy

### Option 2: Deploy via Vercel CLI

#### Install Vercel CLI
```bash
npm i -g vercel
```

#### Deploy Backend
```bash
cd new-project/backend
vercel login
vercel --prod
```

Follow prompts:
- Link to existing project? **N**
- Project name? `ai-project-planner-backend`
- In which directory? `./`

Then set environment variables:
```bash
vercel env add GROQ_API_KEY
```

#### Deploy Frontend
```bash
cd ../frontend
vercel --prod
```

Follow prompts:
- Link to existing project? **N**
- Project name? `ai-project-planner-frontend`
- In which directory? `./`

Then set environment variables:
```bash
vercel env add VITE_API_URL
```

---

## 📋 Pre-Deployment Checklist

### Backend
- [ ] `api/index.py` exists and contains FastAPI app
- [ ] `requirements.txt` has all dependencies
- [ ] `vercel.json` is configured
- [ ] `.vercelignore` excludes unnecessary files
- [ ] `.env` is in `.gitignore` (don't commit secrets!)

### Frontend
- [ ] `package.json` has correct scripts
- [ ] `vite.config.js` is configured
- [ ] `vercel.json` is configured
- [ ] `.vercelignore` excludes node_modules
- [ ] `.env` is in `.gitignore`

---

## 🔐 Environment Variables

### Backend Environment Variables
Set in Vercel Dashboard → Backend Project → Settings → Environment Variables:

| Variable | Value | Where to Get |
|----------|-------|--------------|
| `GROQ_API_KEY` | Your Groq API key | https://console.groq.com |

### Frontend Environment Variables
Set in Vercel Dashboard → Frontend Project → Settings → Environment Variables:

| Variable | Value | Example |
|----------|-------|---------|
| `VITE_API_URL` | Your backend URL | `https://ai-project-planner-backend.vercel.app` |

**Important:** 
- No trailing slash in `VITE_API_URL`
- Must start with `VITE_` for Vite to expose it to the browser

---

## ✅ Verification

### Test Backend
```bash
curl https://your-backend-url.vercel.app/
```

Expected response:
```json
{
  "status": "AI Project Planner API",
  "version": "2.0",
  "endpoints": {
    "chat": "/api/chat",
    "generate_plan": "/api/generate-plan",
    "update_task": "/api/projects/{project_id}/tasks/{task_id}"
  }
}
```

### Test Frontend
1. Visit `https://your-frontend-url.vercel.app`
2. Click "Get Started"
3. Chat with AI
4. Generate Gantt Chart
5. Verify chart displays correctly

---

## 🐛 Troubleshooting

### Git Issues

**Problem:** `fatal: 'origin' does not appear to be a git repository`
```bash
# Solution: Add the remote
git remote add origin https://github.com/yourusername/repo.git
```

**Problem:** Authentication failed
```bash
# Solution 1: Use Personal Access Token
# Go to GitHub → Settings → Developer settings → Personal access tokens
# Generate new token with 'repo' scope
# Use token as password when pushing

# Solution 2: Use SSH
git remote set-url origin git@github.com:yourusername/repo.git
```

**Problem:** Remote already exists
```bash
# Solution: Update the remote URL
git remote set-url origin https://github.com/yourusername/repo.git
```

### Vercel Deployment Issues

**Problem:** Build fails
```bash
# Check Vercel logs in Dashboard → Deployment → Build Logs
# Common fixes:
# - Verify root directory is correct
# - Check requirements.txt or package.json
# - Ensure all files are committed to Git
```

**Problem:** Function crashes (500 error)
```bash
# Check Vercel logs in Dashboard → Deployment → Functions
# Common fixes:
# - Verify environment variables are set
# - Check for import errors in logs
# - Ensure api/index.py exists for backend
```

**Problem:** CORS errors
```bash
# Backend already has CORS configured
# If issues persist:
# - Check browser console for exact error
# - Verify VITE_API_URL is correct
# - Ensure no trailing slash in API URL
```

---

## 🔄 Continuous Deployment

Once connected to GitHub, Vercel automatically deploys:
- **Production:** When you push to `main` branch
- **Preview:** When you push to other branches or create PRs

### Update and Deploy
```bash
# Make changes to your code
git add .
git commit -m "Your commit message"
git push origin main

# Vercel automatically deploys!
```

---

## 📊 Monitoring

### View Deployment Status
- Vercel Dashboard → Your Project
- See all deployments and their status
- Click on a deployment to view logs

### View Function Logs
- Dashboard → Deployment → Functions tab
- Real-time logs for debugging
- Error traces and stack traces

### Analytics
- Dashboard → Project → Analytics
- Response times
- Error rates
- Bandwidth usage

---

## 🎯 Quick Commands Reference

```bash
# Git Commands
git status                          # Check status
git add .                           # Stage all changes
git commit -m "message"             # Commit changes
git push origin main                # Push to GitHub
git remote -v                       # View remotes
git remote add origin <url>         # Add remote
git remote set-url origin <url>     # Update remote

# Vercel Commands
vercel login                        # Login to Vercel
vercel                              # Deploy to preview
vercel --prod                       # Deploy to production
vercel env ls                       # List environment variables
vercel env add VAR_NAME             # Add environment variable
vercel logs                         # View logs
vercel domains                      # Manage domains

# Local Development
cd new-project/backend
python3 main.py                     # Run backend locally

cd new-project/frontend
npm run dev                         # Run frontend locally
```

---

## 🎉 Success Checklist

- [ ] Git repository created on GitHub
- [ ] Code pushed to GitHub
- [ ] Backend deployed to Vercel
- [ ] Frontend deployed to Vercel
- [ ] Environment variables set
- [ ] Backend API responds correctly
- [ ] Frontend loads and displays
- [ ] Chat functionality works
- [ ] Gantt chart generation works
- [ ] Both deployments are connected to GitHub for auto-deploy

---

## 📞 Support Resources

- **Vercel Documentation:** https://vercel.com/docs
- **GitHub Documentation:** https://docs.github.com
- **Groq API Docs:** https://console.groq.com/docs
- **FastAPI Docs:** https://fastapi.tiangolo.com
- **Vite Docs:** https://vitejs.dev

---

## 🔗 Your Deployment URLs

After deployment, save these URLs:

**Backend API:**
```
https://ai-project-planner-backend.vercel.app
```

**Frontend App:**
```
https://ai-project-planner-frontend.vercel.app
```

**GitHub Repository:**
```
https://github.com/yourusername/ai-project-planner
```

---

Good luck with your deployment! 🚀
