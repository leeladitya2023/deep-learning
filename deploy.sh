#!/bin/bash

echo "🚀 Potato Disease Classification App Deployment Script"
echo "=================================================="

echo ""
echo "This script will help you deploy your app to Vercel and a backend platform."
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Git repository not found. Please initialize git first:"
    echo "   git init"
    echo "   git add ."
    echo "   git commit -m 'Initial commit'"
    exit 1
fi

echo "✅ Git repository found"

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
else
    echo "✅ Vercel CLI already installed"
fi

echo ""
echo "🔧 Step 1: Deploy Backend API"
echo "============================="
echo "Choose your backend deployment platform:"
echo "1. Railway (Recommended)"
echo "2. Render"
echo "3. Heroku"
echo "4. Skip backend deployment"
read -p "Enter your choice (1-4): " backend_choice

case $backend_choice in
    1)
        echo "🚂 Deploying to Railway..."
        if ! command -v railway &> /dev/null; then
            echo "📦 Installing Railway CLI..."
            npm install -g @railway/cli
        fi
        echo "Please run the following commands:"
        echo "cd api"
        echo "railway login"
        echo "railway init"
        echo "railway up"
        ;;
    2)
        echo "🎨 Deploying to Render..."
        echo "Please visit https://render.com and:"
        echo "1. Connect your GitHub repository"
        echo "2. Create a new Web Service"
        echo "3. Set build command: pip install -r requirements.txt"
        echo "4. Set start command: uvicorn main:app --host 0.0.0.0 --port \$PORT"
        ;;
    3)
        echo "🦸 Deploying to Heroku..."
        if ! command -v heroku &> /dev/null; then
            echo "📦 Please install Heroku CLI from https://devcenter.heroku.com/articles/heroku-cli"
        else
            echo "Please run the following commands:"
            echo "heroku create your-app-name"
            echo "heroku git:remote -a your-app-name"
            echo "git push heroku main"
        fi
        ;;
    4)
        echo "⏭️  Skipping backend deployment"
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "🎨 Step 2: Deploy Frontend to Vercel"
echo "===================================="

# Check if we're in the right directory
if [ ! -f "frontend/package.json" ]; then
    echo "❌ Frontend directory not found. Please run this script from the project root."
    exit 1
fi

echo "✅ Frontend directory found"

# Deploy to Vercel
echo "🚀 Deploying frontend to Vercel..."
cd frontend

# Check if vercel.json exists
if [ ! -f "vercel.json" ]; then
    echo "❌ vercel.json not found. Please create it first."
    exit 1
fi

echo "📤 Starting Vercel deployment..."
vercel --prod

echo ""
echo "🎉 Deployment completed!"
echo "======================="
echo ""
echo "Next steps:"
echo "1. Get your backend API URL from the platform you chose"
echo "2. Go to your Vercel project settings"
echo "3. Add environment variable:"
echo "   - Name: REACT_APP_API_URL"
echo "   - Value: https://your-backend-url.com/predict"
echo "4. Redeploy your Vercel app"
echo ""
echo "For detailed instructions, see DEPLOYMENT.md" 