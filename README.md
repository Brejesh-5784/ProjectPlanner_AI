# AI Project Planner

A modern chatbot + project planner with Gantt chart visualization. Built with React, FastAPI, and Groq AI.

## 🚀 Quick Start

See [new-project/START_HERE.md](./new-project/START_HERE.md) for deployment instructions.

## Project Structure

```
.
├── netlify.toml              # Netlify configuration (repo root)
├── .gitignore                # Git ignore (repo root)
├── .netlifyignore            # Netlify ignore (repo root)
└── new-project/              # Main project directory
    ├── frontend/             # React frontend
    ├── backend/              # Python FastAPI backend
    └── Documentation files
```

## Features

- 🤖 **AI-Powered Planning**: Chat naturally with AI to create project plans
- 📊 **Interactive Gantt Chart**: Visual timeline with task dependencies
- 🎨 **Modern UI**: Beautiful gradient design with smooth animations
- ⚡ **Real-time Updates**: Instant plan generation and visualization
- 📅 **Smart Scheduling**: Automatic task dependency management
- 👥 **Team Management**: Track team members and assignments

## Tech Stack

**Frontend:**
- React 18
- Vite
- Tailwind CSS
- Lucide Icons
- date-fns

**Backend:**
- FastAPI
- Groq AI (LLaMA 3.3)
- Python 3.9+
- Netlify Functions

## Deployment

This project is configured for **Netlify** deployment.

### Quick Deploy (5 Minutes)

```bash
# 1. Verify setup
bash new-project/verify-netlify-setup.sh

# 2. Push to GitHub
git add .
git commit -m "Ready for Netlify"
git push origin main

# 3. Deploy via Netlify Dashboard
# - Go to https://app.netlify.com/
# - Import from GitHub
# - Netlify auto-detects settings
# - Add GROQ_API_KEY environment variable
# - Deploy!
```

See [new-project/QUICKSTART.md](./new-project/QUICKSTART.md) for detailed instructions.

## Local Development

### Backend

```bash
cd new-project/backend
pip install -r requirements.txt
python app.py
# Visit http://localhost:8000
```

### Frontend

```bash
cd new-project/frontend
npm install
npm run dev
# Visit http://localhost:3000
```

## Documentation

- **[START_HERE.md](./new-project/START_HERE.md)** - Your starting point
- **[QUICKSTART.md](./new-project/QUICKSTART.md)** - 5-minute deployment guide
- **[DEPLOY_NETLIFY.md](./new-project/DEPLOY_NETLIFY.md)** - Detailed deployment instructions
- **[DEPLOYMENT_CHECKLIST.md](./new-project/DEPLOYMENT_CHECKLIST.md)** - Verification checklist

## Environment Variables

### Required for Production
- `GROQ_API_KEY` - Your Groq API key (set in Netlify Dashboard)

### For Local Development
- Create `new-project/backend/.env` from `.env.example`
- Add your `GROQ_API_KEY`

## License

MIT
