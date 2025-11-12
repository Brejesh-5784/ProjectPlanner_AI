# 📋 Netlify Deployment Checklist

## ✅ Pre-Deployment Verification

### Backend Files
- [x] `backend/netlify/functions/api.py` - Serverless function entry point
- [x] `backend/requirements.txt` - Includes mangum==0.17.0
- [x] `backend/runtime.txt` - Python 3.9
- [x] `backend/app.py` - Local development server (not deployed)
- [x] `backend/main.py` - Legacy file (not deployed)

### Frontend Files
- [x] `frontend/src/` - React source code
- [x] `frontend/package.json` - Dependencies and build scripts
- [x] `frontend/vite.config.js` - Vite configuration
- [x] `frontend/.env.example` - Environment template
- [x] `frontend/.env.production` - Production env (empty VITE_API_URL)

### Configuration Files
- [x] `netlify.toml` - Main Netlify configuration
- [x] `.gitignore` - Excludes .env, node_modules, etc.
- [x] `DEPLOY_NETLIFY.md` - Deployment guide
- [x] `README.md` - Updated for Netlify

### Removed Vercel Files
- [x] Deleted `backend/vercel.json`
- [x] Deleted `frontend/vercel.json`
- [x] Deleted `backend/api/index.py`
- [x] Deleted `DEPLOY_NOW.md`
- [x] Deleted `backend/VERCEL_DEPLOYMENT_OPTIONS.md`

## 🚀 Deployment Steps

### 1. Verify Local Setup

```bash
# Test backend locally
cd new-project/backend
pip install -r requirements.txt
python app.py
# Visit http://localhost:8000 - should see API status

# Test frontend locally
cd new-project/frontend
npm install
npm run dev
# Visit http://localhost:3000 - should see landing page
```

### 2. Commit and Push

```bash
cd new-project
git add .
git commit -m "Configure for Netlify deployment"
git push origin main
```

### 3. Deploy to Netlify

#### Option A: Netlify Dashboard
1. Go to https://app.netlify.com/
2. Click "Add new site" → "Import an existing project"
3. Choose GitHub and select your repo
4. Netlify auto-detects `netlify.toml`
5. Add environment variable: `GROQ_API_KEY`
6. Click "Deploy site"

#### Option B: Netlify CLI
```bash
npm install -g netlify-cli
netlify login
cd new-project
netlify init
netlify env:set GROQ_API_KEY "your_key_here"
netlify deploy --prod
```

### 4. Verify Deployment

```bash
# Test API
curl https://your-site.netlify.app/api/

# Expected response:
# {
#   "status": "AI Project Planner API",
#   "version": "2.0",
#   "platform": "Netlify Functions"
# }
```

### 5. Test Full Flow

1. Visit `https://your-site.netlify.app`
2. Click "Get Started"
3. Chat: "Build a MERN app in 30 days with 5 people"
4. Click "Generate Gantt Chart"
5. Verify chart displays with tasks

## 🔍 Troubleshooting

### Issue: Build Fails

**Check:**
- Build logs in Netlify dashboard
- Verify `netlify.toml` paths are correct
- Ensure `frontend/package.json` has `build` script

**Solution:**
```bash
# Test build locally
cd frontend
npm run build
# Should create dist/ directory
```

### Issue: Function Timeout

**Check:**
- Function logs in Netlify dashboard
- Groq API response time

**Solution:**
- Free tier: 10s timeout (may be tight)
- Upgrade to Pro: 26s timeout
- Or use Background Functions: 15min timeout

### Issue: GROQ_API_KEY Not Found

**Check:**
- Environment variables in Netlify dashboard
- Variable name is exactly `GROQ_API_KEY`

**Solution:**
1. Site settings → Environment variables
2. Add `GROQ_API_KEY` with your key
3. Redeploy

### Issue: API Returns 404

**Check:**
- Redirects in `netlify.toml`
- Function file location: `backend/netlify/functions/api.py`

**Solution:**
- Verify `netlify.toml` redirects section
- Check function logs for errors

### Issue: CORS Errors

**Check:**
- Frontend making requests to correct URL
- Backend CORS configuration

**Solution:**
- Production: Use relative URLs (`/api/*`)
- Local dev: Use `http://localhost:8000`
- CORS already configured in `api.py`

## 📊 Post-Deployment Monitoring

### Check These Metrics

1. **Function Invocations**
   - Netlify Dashboard → Functions → api
   - Should see successful invocations

2. **Error Rate**
   - Should be <5%
   - Check logs for errors

3. **Response Time**
   - Chat: <5s
   - Generate Plan: <25s

4. **Build Time**
   - Should be <3 minutes

### View Logs

```bash
# Using Netlify CLI
netlify functions:log api

# Or in dashboard
# Functions → api → View logs
```

## 🎯 Success Criteria

- [ ] Site loads at `https://your-site.netlify.app`
- [ ] Landing page displays correctly
- [ ] "Get Started" navigates to planner
- [ ] Chat interface responds to messages
- [ ] "Generate Gantt Chart" creates timeline
- [ ] Gantt chart displays with colored bars
- [ ] Tasks are clickable and show details
- [ ] Progress tracker updates
- [ ] Team member cards display
- [ ] No console errors
- [ ] API endpoint responds: `/api/`

## 🔄 Continuous Deployment

Once connected to GitHub:

- **Auto-deploy on push to main**
- **Preview deploys for PRs**
- **Rollback available in dashboard**

### Update Workflow

```bash
# Make changes
git add .
git commit -m "Update feature"
git push origin main

# Netlify automatically deploys
# Check status: netlify status
```

## 🌐 Custom Domain Setup

1. Netlify Dashboard → Domain settings
2. Add custom domain
3. Configure DNS (Netlify provides instructions)
4. SSL auto-generated (free)

## 📞 Need Help?

- **Netlify Docs:** https://docs.netlify.com/
- **Netlify Support:** https://answers.netlify.com/
- **Project Docs:** See `DEPLOY_NETLIFY.md`

## ✨ You're Ready!

All files are configured and ready for Netlify deployment.

Follow the steps above and your AI Project Planner will be live! 🚀
