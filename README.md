# 🤖 AI Project Planner 

> AI-powered project planner with interactive Gantt charts. Chat naturally to generate comprehensive project timelines. Built with React, FastAPI & Groq AI.

[![Live Demo](https://img.shields.io/badge/demo-live-success?style=for-the-badge)](https://projectplannerai.netlify.app)

**🌐 Live Demo:** [https://projectplannerai.netlify.app](https://projectplannerai.netlify.app)

---

##  Features

- 🤖 **AI-Powered Planning** - Chat with AI to create project plans
- 📊 **Interactive Gantt Chart** - Visual timeline with dependencies
- 🎨 **Modern UI** - Beautiful gradient design
- ⚡ **Real-time Updates** - Instant plan generation
- 📅 **Smart Scheduling** - Automatic task dependencies
- 👥 **Team Management** - Track assignments and workload

---

## 🛠️ Tech Stack

**Frontend:** React 18, Vite, Tailwind CSS, Lucide Icons  
**Backend:** FastAPI, Groq AI (LLaMA 3.3), Python 3.9  
**Deployment:** Netlify (Frontend) + Render (Backend)

---

## 🚀 Quick Start

### Prerequisites
- Node.js 16+
- Python 3.9+
- Groq API key ([Get free](https://console.groq.com))

### Backend Setup

```bash
cd new-project/backend

# Install dependencies
pip install -r requirements.txt

# Create .env file
cp .env.example .env
# Add your GROQ_API_KEY to .env

# Run server
uvicorn api:app --reload --port 8000
```

Backend runs at: **http://localhost:8000**

### Frontend Setup

```bash
cd new-project/frontend

# Install dependencies
npm install

# Run dev server
npm run dev
```

Frontend runs at: **http://localhost:3000**

---

## 🌐 Deployment

### Backend (Render)

1. Go to [render.com](https://render.com)
2. Create **Web Service**
3. Configure:
   - **Root Directory:** `new-project/backend`
   - **Build Command:** `pip install -r requirements.txt`
   - **Start Command:** `uvicorn api:app --host 0.0.0.0 --port $PORT`
4. Add environment variable: `GROQ_API_KEY`
5. Deploy!

**Backend URL:** `https://projectplanner-backend-0rsl.onrender.com`

### Frontend (Netlify)

1. Go to [netlify.com](https://netlify.com)
2. Import from GitHub
3. Configure:
   - **Base directory:** `new-project/frontend`
   - **Build command:** `npm install && npm run build`
   - **Publish directory:** `dist`
4. Add environment variable: `VITE_API_URL` = your Render backend URL
5. Deploy!

**Frontend URL:** `https://projectplannerai.netlify.app`

---

## 📁 Project Structure

```
.
├── README.md                   # This file
├── new-project/
│   ├── backend/                # Python FastAPI backend
│   │   ├── api.py             # Main API file
│   │   ├── requirements.txt   # Python dependencies
│   │   └── .env.example       # Environment template
│   └── frontend/              # React frontend
│       ├── src/               # Source code
│       ├── package.json       # Node dependencies
│       └── .env.example       # Environment template
```

---

## 🔐 Environment Variables

### Backend
```bash
GROQ_API_KEY=your_groq_api_key_here
```

### Frontend
```bash
VITE_API_URL=http://localhost:8000  # Local dev
# VITE_API_URL=https://your-backend.onrender.com  # Production
```

---

## 🎯 Usage

1. Open the app
2. Click **"Get Started"**
3. Chat: "Build a website in 30 days with 5 people"
4. Click **"Generate Gantt Chart"**
5. View your project timeline!

---

## 📊 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api` | GET | Health check |
| `/api/chat` | POST | Chat with AI |
| `/api/generate-plan` | POST | Generate project plan |
| `/api/debug` | GET | Debug info |

---

## 🤝 Contributing

Contributions welcome! Feel free to submit a Pull Request.

---

## 📝 License

MIT License - feel free to use this project for anything!

---

## 🙏 Acknowledgments

- **Groq** - Fast LLM inference
- **Render** - Backend hosting
- **Netlify** - Frontend hosting
- **FastAPI** - Python web framework
- **React** - UI library

---

## 📧 Contact

- **Live Demo:** [https://projectplannerai.netlify.app](https://projectplannerai.netlify.app)
- **Backend API:** [https://projectplanner-backend-0rsl.onrender.com](https://projectplanner-backend-0rsl.onrender.com)
- **Repository:** [github.com/Brejesh-5784/ProjectPlanner_AI](https://github.com/Brejesh-5784/ProjectPlanner_AI)

---

<div align="center">

**Made with using React, FastAPI, and Groq AI**

[Live Demo](https://projectplannerai.netlify.app) • [Report Bug](https://github.com/Brejesh-5784/ProjectPlanner_AI/issues)

</div>
