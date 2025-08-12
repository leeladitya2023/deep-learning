@echo off
echo 🚀 Potato Disease Classification App Deployment Script
echo ==================================================
echo.

echo This script will help you deploy your app to Vercel and a backend platform.
echo.

REM Check if git is initialized
if not exist ".git" (
    echo ❌ Git repository not found. Please initialize git first:
    echo    git init
    echo    git add .
    echo    git commit -m "Initial commit"
    pause
    exit /b 1
)

echo ✅ Git repository found

REM Check if Vercel CLI is installed
vercel --version >nul 2>&1
if errorlevel 1 (
    echo 📦 Installing Vercel CLI...
    npm install -g vercel
) else (
    echo ✅ Vercel CLI already installed
)

echo.
echo 🔧 Step 1: Deploy Backend API
echo =============================
echo Choose your backend deployment platform:
echo 1. Railway (Recommended)
echo 2. Render
echo 3. Heroku
echo 4. Skip backend deployment
set /p backend_choice="Enter your choice (1-4): "

if "%backend_choice%"=="1" (
    echo 🚂 Deploying to Railway...
    railway --version >nul 2>&1
    if errorlevel 1 (
        echo 📦 Installing Railway CLI...
        npm install -g @railway/cli
    )
    echo Please run the following commands:
    echo cd api
    echo railway login
    echo railway init
    echo railway up
) else if "%backend_choice%"=="2" (
    echo 🎨 Deploying to Render...
    echo Please visit https://render.com and:
    echo 1. Connect your GitHub repository
    echo 2. Create a new Web Service
    echo 3. Set build command: pip install -r requirements.txt
    echo 4. Set start command: uvicorn main:app --host 0.0.0.0 --port %%PORT%%
) else if "%backend_choice%"=="3" (
    echo 🦸 Deploying to Heroku...
    heroku --version >nul 2>&1
    if errorlevel 1 (
        echo 📦 Please install Heroku CLI from https://devcenter.heroku.com/articles/heroku-cli
    ) else (
        echo Please run the following commands:
        echo heroku create your-app-name
        echo heroku git:remote -a your-app-name
        echo git push heroku main
    )
) else if "%backend_choice%"=="4" (
    echo ⏭️  Skipping backend deployment
) else (
    echo ❌ Invalid choice
    pause
    exit /b 1
)

echo.
echo 🎨 Step 2: Deploy Frontend to Vercel
echo ====================================

REM Check if we're in the right directory
if not exist "frontend\package.json" (
    echo ❌ Frontend directory not found. Please run this script from the project root.
    pause
    exit /b 1
)

echo ✅ Frontend directory found

REM Deploy to Vercel
echo 🚀 Deploying frontend to Vercel...
cd frontend

REM Check if vercel.json exists
if not exist "vercel.json" (
    echo ❌ vercel.json not found. Please create it first.
    pause
    exit /b 1
)

echo 📤 Starting Vercel deployment...
vercel --prod

echo.
echo 🎉 Deployment completed!
echo =======================
echo.
echo Next steps:
echo 1. Get your backend API URL from the platform you chose
echo 2. Go to your Vercel project settings
echo 3. Add environment variable:
echo    - Name: REACT_APP_API_URL
echo    - Value: https://your-backend-url.com/predict
echo 4. Redeploy your Vercel app
echo.
echo For detailed instructions, see DEPLOYMENT.md
pause 