# 🚀 Deploy AI Project Planner to Netlify

## ✅ What's Been Configured

Your project is now **READY FOR NETLIFY** with:

- ✅ `netlify.toml` - Main configuration file
- ✅ `backend/netlify/functions/api.py` - Serverless function
- ✅ `backend/requirements.txt` - Updated with Mangum adapter
- ✅ `backend/runtime.txt` - Python 3.9 runtime
- ✅ API redirects configured
- ✅ SPA routing for React
- ✅ Security headers
- ✅ Asset caching

## 🎯 Deployment Steps

### Option 1: Deploy via Netlify Dashboard (Recommended)

#### Step 1: Push to GitHub

```bash
cd new-project
git add .
git commit -m "Configure for Netlify deployment"
git push origin main
```

#### Step 2: Connect to Netlify

1. Go to https://app.netlify.com/
2. Click **"Add new site"** → **"Import an existing project"**
3. Choose **GitHub** and authorize Netlify
4. Select your repository: `Brejesh-5784/chat`
5. Netlify will auto-detect the `netlify.toml` configuration

#### Step 3: Configure Build Settings

Netlify should auto-detect from `netlify.toml`:
- **Base directory:** `new-project/frontend`
- **Build command:** `npm install && npm run build`
- **Publish directory:** `dist`
- **Functions directory:** `../backend/netlify/functions`

If not auto-detected, enter these manually.

#### Step 4: Add Environment Variables

Before deploying, add your API key:

1. Go to **Site settings** → **Environment variables**
2. Click **"Add a variable"**
3. Add:
   ```
   Key: GROQ_API_KEY
   Value: [Your Groq API Key from console.groq.com]
   ```
4. Click **"Save"**

#### Step 5: Deploy

1. Click **"Deploy site"**
2. Wait 2-5 minutes for build
3. Your site will be live at: `https://your-site-name.netlify.app`

---

### Option 2: Deploy via Netlify CLI

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login to Netlify
netlify login

# Initialize site
cd new-project
netlify init

# Set environment variable
netlify env:set GROQ_API_KEY "your_groq_api_key_here"

# Deploy
netlify deploy --prod
```

---

## 🧪 Testing Your Deployment

### Test Backend API

```bash
curl https://your-site-name.netlify.app/api/
```

Expected response:
```json
{
  "status": "AI Project Planner API",
  "version": "2.0",
  "platform": "Netlify Functions"
}
```

### Test Frontend

1. Visit: `https://your-site-name.netlify.app`
2. Click **"Get Started"**
3. Chat with AI about your project
4. Click **"Generate Gantt Chart"**
5. Verify the Gantt chart displays

---

## 📋 How It Works

### Architecture

```
User Request
    ↓
Netlify CDN (Frontend)
    ↓
/api/* requests → Netlify Functions (Backend)
    ↓
Groq AI API
    ↓
Response back to user
```

### File Structure

```
new-project/
├── netlify.toml                    # Main config
├── frontend/
│   ├── dist/                       # Built files (published)
│   ├── src/
│   └── package.json
└── backend/
    ├── netlify/
    │   └── functions/
    │       └── api.py              # Serverless function
    ├── requirements.txt            # Python dependencies
    └── runtime.txt                 # Python version
```

### Key Differences from Vercel

| Feature | Vercel | Netlify |
|---------|--------|---------|
| Config File | `vercel.json` | `netlify.toml` |
| Functions Dir | `api/` | `netlify/functions/` |
| Python Adapter | Native | Mangum (ASGI) |
| Timeout (Free) | 10s | 10s |
| Timeout (Pro) | 60s | 26s (Background: 15min) |
| Max Function Size | 50 MB | 50 MB |

---

## 🔧 Configuration Explained

### netlify.toml

```toml
[build]
  base = "new-project/frontend"           # Where to run build
  command = "npm install && npm run build" # Build command
  publish = "dist"                         # Output directory
  functions = "../backend/netlify/functions" # Functions location

[[redirects]]
  from = "/api/*"                          # API requests
  to = "/.netlify/functions/api/:splat"   # Route to function
  status = 200
  force = true

[[redirects]]
  from = "/*"                              # All other requests
  to = "/index.html"                       # SPA routing
  status = 200
```

### backend/netlify/functions/api.py

- Uses **Mangum** to wrap FastAPI for AWS Lambda/Netlify
- Lazy loads Groq client to avoid cold start issues
- Includes timeout protection (20s chat, 25s plan generation)
- Optimized for serverless environment

---

## 🚨 Troubleshooting

### Issue: "Function timeout"

**Solution:**
- Free tier: 10s timeout (may be tight for AI calls)
- Upgrade to Netlify Pro for 26s timeout
- Or use Background Functions (15 min timeout)

### Issue: "GROQ_API_KEY not found"

**Solution:**
1. Go to Site settings → Environment variables
2. Add `GROQ_API_KEY`
3. Redeploy: `netlify deploy --prod`

### Issue: "Module not found: mangum"

**Solution:**
- Ensure `mangum==0.17.0` is in `requirements.txt`
- Redeploy to reinstall dependencies

### Issue: "Build failed"

**Solution:**
1. Check build logs in Netlify dashboard
2. Verify `netlify.toml` paths are correct
3. Ensure `frontend/package.json` has build script

### Issue: "API returns 404"

**Solution:**
- Check redirects in `netlify.toml`
- Verify function file is at `backend/netlify/functions/api.py`
- Check function logs in Netlify dashboard

---

## 📊 Monitoring

### View Logs

1. Netlify Dashboard → Your Site
2. Go to **"Functions"** tab
3. Click on `api` function
4. View real-time logs and invocations

### Performance Metrics

Check in Netlify Dashboard:
- Function invocations
- Execution time
- Error rates
- Bandwidth usage

---

## 🔄 Continuous Deployment

Once connected to GitHub, Netlify automatically deploys:

- **Production:** Push to `main` branch
- **Preview:** Push to other branches or PRs

### Update and Deploy

```bash
# Make changes
git add .
git commit -m "Update feature"
git push origin main

# Netlify automatically deploys! 🚀
```

---

## 🌐 Custom Domain (Optional)

### Add Custom Domain

1. Netlify Dashboard → Your Site
2. Go to **"Domain settings"**
3. Click **"Add custom domain"**
4. Follow DNS configuration instructions
5. SSL certificate auto-generated (free)

---

## ⚡ Performance Tips

### 1. Enable Netlify Edge Functions (Faster)

For even better performance, consider upgrading to Edge Functions:
- Lower latency (runs closer to users)
- Faster cold starts
- Available on Pro plan

### 2. Optimize Frontend Build

```bash
# In frontend directory
npm run build -- --mode production
```

### 3. Use Background Functions for Long Tasks

If AI generation takes >10s, use background functions:

```python
# In api.py
@app.post("/api/generate-plan-background")
async def generate_plan_background(request: ChatRequest, background_tasks: BackgroundTasks):
    # Process in background
    pass
```

---

## 📞 Support

If you encounter issues:

1. **Check Netlify Function Logs** (most issues show here)
2. **Verify Environment Variables** (GROQ_API_KEY)
3. **Check netlify.toml paths** (must be relative to repo root)
4. **Redeploy** after configuration changes

---

## ✨ Your Deployment URLs

After successful deployment:

**Production Site:**
```
https://your-site-name.netlify.app
```

**API Endpoint:**
```
https://your-site-name.netlify.app/api/
```

**GitHub Repository:**
```
https://github.com/Brejesh-5784/chat
```

---

## 🎯 Quick Deploy Commands

```bash
# One-time setup
npm install -g netlify-cli
netlify login

# Deploy
cd new-project
netlify init
netlify env:set GROQ_API_KEY "your_key_here"
netlify deploy --prod
```

---

**Your project is now READY FOR NETLIFY! 🚀**

Follow the steps above and your AI Project Planner will be live in minutes!
