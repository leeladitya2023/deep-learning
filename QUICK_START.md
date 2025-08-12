# Quick Start: Deploy to Vercel

## Prerequisites

1. **GitHub Account**: Make sure your code is pushed to GitHub
2. **Vercel Account**: Sign up at [vercel.com](https://vercel.com)
3. **Backend Platform**: Choose Railway, Render, or Heroku for the API

## Step 1: Deploy Backend (Choose One)

### Option A: Railway (Easiest)
```bash
# Install Railway CLI
npm install -g @railway/cli

# Deploy from api directory
cd api
railway login
railway init
railway up
```

### Option B: Render
1. Go to [render.com](https://render.com)
2. Connect your GitHub repo
3. Create Web Service
4. Set build: `pip install -r requirements.txt`
5. Set start: `uvicorn main:app --host 0.0.0.0 --port $PORT`

### Option C: Heroku
```bash
# Install Heroku CLI
# Create Procfile in api/ with: web: uvicorn main:app --host 0.0.0.0 --port $PORT

cd api
heroku create your-app-name
heroku git:remote -a your-app-name
git push heroku main
```

## Step 2: Deploy Frontend to Vercel

1. **Go to Vercel Dashboard**: [vercel.com/dashboard](https://vercel.com/dashboard)

2. **Import Project**:
   - Click "New Project"
   - Import your GitHub repository
   - Set root directory to `frontend`
   - Vercel will auto-detect React

3. **Configure Environment Variables**:
   - Go to Project Settings → Environment Variables
   - Add: `REACT_APP_API_URL` = `https://your-backend-url.com/predict`

4. **Deploy**:
   - Click "Deploy"
   - Wait for build to complete

## Step 3: Test Your App

1. Visit your Vercel URL
2. Upload a potato leaf image
3. Verify predictions work

## Troubleshooting

### CORS Errors
Update `api/main.py` origins:
```python
origins = [
    "http://localhost",
    "http://localhost:3000",
    "https://*.vercel.app",
    "https://*.railway.app",
    "https://*.render.com",
    "https://*.herokuapp.com",
]
```

### Model Loading Issues
- Ensure `saved_models/1/` is included in your repository
- Or host model files on cloud storage

### API URL Issues
- Verify `REACT_APP_API_URL` is set correctly in Vercel
- Test API endpoint directly with Postman

## Need Help?

- Check deployment logs in your platform dashboard
- See full guide in `DEPLOYMENT.md`
- Test API independently before connecting frontend 