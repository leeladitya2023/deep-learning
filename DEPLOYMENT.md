# Deployment Guide for Potato Disease Classification App

This guide will help you deploy the potato disease classification app to Vercel (frontend) and a suitable backend platform.

## Overview

The app consists of:
- **Frontend**: React.js application for image upload and display
- **Backend**: FastAPI application with TensorFlow model for disease classification

## Deployment Strategy

Since Vercel is primarily for frontend deployment and has limitations with large ML models, we'll use:
1. **Vercel** for the React frontend
2. **Railway/Render/Heroku** for the FastAPI backend

## Step 1: Deploy Backend API

### Option A: Deploy to Railway (Recommended)

1. **Sign up for Railway**: Go to [railway.app](https://railway.app) and create an account

2. **Create a new project**:
   ```bash
   # Install Railway CLI
   npm install -g @railway/cli
   
   # Login to Railway
   railway login
   
   # Navigate to the api directory
   cd api
   
   # Initialize Railway project
   railway init
   ```

3. **Configure the project**:
   - Railway will automatically detect it's a Python project
   - Make sure `requirements.txt` is in the api directory
   - The model files need to be accessible

4. **Deploy**:
   ```bash
   railway up
   ```

5. **Get your API URL**: Railway will provide a URL like `https://your-app-name.railway.app`

### Option B: Deploy to Render

1. **Sign up for Render**: Go to [render.com](https://render.com)

2. **Create a new Web Service**:
   - Connect your GitHub repository
   - Set build command: `pip install -r requirements.txt`
   - Set start command: `uvicorn main:app --host 0.0.0.0 --port $PORT`

3. **Environment Variables**: Add any necessary environment variables

4. **Deploy**: Render will automatically deploy your app

### Option C: Deploy to Heroku

1. **Sign up for Heroku**: Go to [heroku.com](https://heroku.com)

2. **Create a new app**:
   ```bash
   # Install Heroku CLI
   # Create Procfile in api directory with:
   # web: uvicorn main:app --host 0.0.0.0 --port $PORT
   
   heroku create your-app-name
   heroku git:remote -a your-app-name
   git push heroku main
   ```

## Step 2: Deploy Frontend to Vercel

1. **Sign up for Vercel**: Go to [vercel.com](https://vercel.com)

2. **Connect your repository**:
   - Import your GitHub repository
   - Set the root directory to `frontend`
   - Vercel will automatically detect it's a React app

3. **Configure environment variables**:
   - Go to your Vercel project settings
   - Add environment variable:
     - Name: `REACT_APP_API_URL`
     - Value: Your backend API URL (e.g., `https://your-app-name.railway.app/predict`)

4. **Deploy**:
   - Vercel will automatically build and deploy your app
   - You'll get a URL like `https://your-app-name.vercel.app`

## Step 3: Update CORS Settings

Make sure your backend API allows requests from your Vercel domain:

```python
# In api/main.py, update the origins list:
origins = [
    "http://localhost",
    "http://localhost:3000",
    "https://your-app-name.vercel.app",  # Add your Vercel URL
]
```

## Step 4: Test the Deployment

1. Visit your Vercel frontend URL
2. Upload a potato leaf image
3. Verify the prediction works correctly

## Troubleshooting

### Common Issues:

1. **CORS Errors**: Make sure your backend allows requests from your Vercel domain
2. **Model Loading Issues**: Ensure your model files are properly included in the backend deployment
3. **API URL Issues**: Verify the `REACT_APP_API_URL` environment variable is set correctly

### Model File Handling:

For Railway/Render/Heroku, you may need to:
1. Include the model files in your repository
2. Or host the model files on a cloud storage service (AWS S3, Google Cloud Storage)
3. Update the model loading path in your API code

## Alternative: Full-Stack Deployment

If you prefer to deploy everything together, consider:
- **Railway**: Supports both frontend and backend
- **Render**: Can host both React and FastAPI
- **Heroku**: Supports full-stack applications

## Environment Variables Reference

### Frontend (.env):
```
REACT_APP_API_URL=https://your-backend-url.com/predict
```

### Backend:
```
PORT=8000
MODEL_PATH=../saved_models/1
```

## Support

If you encounter issues:
1. Check the deployment platform's logs
2. Verify all environment variables are set correctly
3. Ensure your model files are accessible
4. Test the API endpoints independently using tools like Postman 