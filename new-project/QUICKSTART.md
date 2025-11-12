# 🚀 Quick Start - Deploy to Netlify in 5 Minutes

## Prerequisites

- GitHub account
- Netlify account (free tier works)
- Groq API key (get from https://console.groq.com/)

## Step 1: Push to GitHub (1 min)

```bash
cd new-project
git add .
git commit -m "Ready for Netlify deployment"
git push origin main
```

## Step 2: Deploy to Netlify (2 min)

### Via Dashboard (Easiest)

1. Go to https://app.netlify.com/
2. Click **"Add new site"** → **"Import an existing project"**
3. Select **GitHub** and authorize
4. Choose your repository
5. Netlify auto-detects settings from `netlify.toml` ✅
6. Click **"Deploy site"**

### Via CLI (Alternative)

```bash
npm install -g netlify-cli
netlify login
netlify init
netlify deploy --prod
```

## Step 3: Add API Key (1 min)

1. In Netlify Dashboard, go to **Site settings**
2. Click **Environment variables**
3. Add variable:
   - **Key:** `GROQ_API_KEY`
   - **Value:** Your Groq API key
4. Click **Save**
5. Go to **Deploys** → **Trigger deploy** → **Deploy site**

## Step 4: Test (1 min)

Visit your site: `https://your-site-name.netlify.app`

1. Click **"Get Started"**
2. Type: "Build a website in 30 days with 5 people"
3. Click **"Generate Gantt Chart"**
4. See your project timeline! 🎉

## ✅ Done!

Your AI Project Planner is now live on Netlify!

## 🔧 Troubleshooting

### Build Failed?
- Check build logs in Netlify dashboard
- Verify `netlify.toml` is in repo root

### API Not Working?
- Verify `GROQ_API_KEY` is set in environment variables
- Check function logs: Functions → api → View logs

### Need More Help?
- See [DEPLOY_NETLIFY.md](./DEPLOY_NETLIFY.md) for detailed guide
- See [DEPLOYMENT_CHECKLIST.md](./DEPLOYMENT_CHECKLIST.md) for verification

## 📊 What Got Deployed?

- **Frontend:** React app built with Vite
- **Backend:** Python FastAPI as Netlify Function
- **API Routes:** `/api/*` redirects to serverless function
- **CDN:** Global edge network for fast loading

## 🎯 Next Steps

- Add custom domain (optional)
- Monitor usage in Netlify dashboard
- Update code and push - auto-deploys!

---

**Total Time:** ~5 minutes
**Cost:** Free (Netlify free tier)
**Maintenance:** Zero - auto-deploys on git push
