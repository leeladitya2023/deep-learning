# Render Deployment Guide

## Current Issue
Your Render deployment is failing because:
1. Render is detecting this as a Node.js project instead of Python
2. The start command is not properly configured

## Solution

### Option 1: Use render.yaml (Recommended)

1. **The `render.yaml` file is already created** - this will tell Render this is a Python project

2. **In Render Dashboard**:
   - Go to your project settings
   - Make sure the following are set:
     - **Environment**: Python
     - **Build Command**: `pip install -r api/requirements.txt`
     - **Start Command**: `cd api && uvicorn main:app --host 0.0.0.0 --port $PORT`

3. **Redeploy**: Click "Manual Deploy" → "Deploy latest commit"

### Option 2: Manual Configuration

If the render.yaml doesn't work, manually configure in Render dashboard:

1. **Environment**: Python
2. **Build Command**: `pip install -r api/requirements.txt`
3. **Start Command**: `cd api && uvicorn main:app --host 0.0.0.0 --port $PORT`
4. **Python Version**: 3.9

### Option 3: Alternative Start Command

If you still have issues, try this start command:
```bash
cd api && python -m uvicorn main:app --host 0.0.0.0 --port $PORT
```

## Model Files Issue

The TensorFlow model files might be too large for Render. Solutions:

### Option A: Include in Repository (if < 100MB)
Make sure `saved_models/1/` is included in your Git repository.

### Option B: Host Model Files Externally
1. Upload model files to Google Drive or AWS S3
2. Update the model loading code to download from URL

### Option C: Use Smaller Model
Convert your model to TensorFlow Lite format (much smaller).

## Environment Variables

Add these in Render dashboard:
- `PORT`: Will be set automatically by Render
- `MODEL_PATH`: `../saved_models/1` (or your model path)

## Troubleshooting

### If Build Fails:
1. Check the build logs in Render dashboard
2. Make sure all dependencies are in `api/requirements.txt`
3. Try updating TensorFlow version if needed

### If Start Fails:
1. Check the start command is correct
2. Make sure the model files are accessible
3. Verify the API code doesn't have syntax errors

### If Model Loading Fails:
1. Check if model files are included in repository
2. Verify the model path is correct
3. Consider using a smaller model format

## Quick Fix Steps

1. **Update your repository** with the new files:
   ```bash
   git add .
   git commit -m "Add Render configuration"
   git push
   ```

2. **In Render dashboard**:
   - Go to your service
   - Click "Manual Deploy"
   - Select "Deploy latest commit"

3. **Monitor the deployment**:
   - Check build logs
   - Check start logs
   - Test the API endpoint

## Test Your API

Once deployed, test with:
```bash
curl -X POST "https://your-app-name.onrender.com/predict" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@test_image.jpg"
```

## Next Steps

After successful API deployment:
1. Get your Render API URL
2. Deploy frontend to Vercel
3. Set `REACT_APP_API_URL` environment variable in Vercel 