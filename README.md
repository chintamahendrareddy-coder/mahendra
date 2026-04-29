# 🏦 Bank Admin App — Railway Deployment Guide

## Project Structure
```
bankapp/
├── Dockerfile              ← Builds & runs on Tomcat
├── railway.toml            ← Railway configuration
├── pom.xml                 ← Maven build (downloads JDBC driver)
├── .gitignore
└── src/
    └── main/
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml
            ├── dbconnect.jsp   ← DB config (uses env vars)
            ├── index.jsp
            ├── login.jsp
            ├── home.jsp
            └── ... (all other JSP files)
```

---

## 🚀 Step-by-Step: Deploy on Railway

### Step 1 — Create a GitHub Repository
1. Go to https://github.com and create a **new repository** (e.g. `bank-admin-app`)
2. Upload this entire `bankapp/` folder to the repo

### Step 2 — Create a Railway Account
1. Go to https://railway.app
2. Sign up using your **GitHub account**

### Step 3 — Create a New Project
1. Click **"New Project"**
2. Select **"Deploy from GitHub repo"**
3. Choose your `bank-admin-app` repository
4. Railway will auto-detect the `Dockerfile` and start building ✅

### Step 4 — Set Environment Variables
Go to your Railway project → **Variables** tab → Add these:

| Variable      | Value                        |
|---------------|------------------------------|
| `DB_HOST`     | your SQL Server host/IP      |
| `DB_PORT`     | `1433`                       |
| `DB_NAME`     | `bankdb`                     |
| `DB_USER`     | `sa`                         |
| `DB_PASSWORD` | your SQL Server password     |

### Step 5 — Get Your Public URL
1. Go to **Settings** tab in Railway
2. Click **"Generate Domain"**
3. Your app will be live at: `https://your-app-name.up.railway.app` 🎉

---

## 🗄️ Database Options

Since Railway doesn't support SQL Server natively, you have **two options**:

### Option A — Keep your existing SQL Server (Recommended if you have one hosted)
- Use your current SQL Server's **public IP** in `DB_HOST`
- Make sure port `1433` is open in your firewall

### Option B — Migrate to PostgreSQL (Free on Railway)
- Add a PostgreSQL plugin inside Railway (free tier available)
- Rewrite SQL queries from T-SQL to PostgreSQL syntax

---

## 🔑 Default Login
- **Username:** `admin`
- **Password:** `admin123`

---

## ⚠️ Security Notes
- Change the default admin password in `login.jsp` before going live
- Never commit real passwords — always use environment variables
