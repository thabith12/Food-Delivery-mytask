# Troubleshooting & Setup Documentation

This document logs the configuration details, setup instructions, issues identified during development/testing, and the solutions applied for the Food Delivery application (Backend, Frontend, and Admin Panel).

---

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Prerequisites](#prerequisites)
3. [Environment Configuration Guide](#environment-configuration-guide)
4. [Step-by-Step Installation & Run Guide](#step-by-step-installation--run-guide)
5. [Troubleshooting & Bug Fixes Log](#troubleshooting--bug-fixes-log)
6. [GitFlow Branching Strategy](#gitflow-branching-strategy)

---

## 🔍 Project Overview

The application is a full-stack Food Delivery platform divided into three main folders:
- **`backend/`**: Node.js & Express REST API using Mongoose/MongoDB, JWT authentication, and Stripe payments.
- **`frontend/`**: React application using Vite for client-side ordering, cart management, and Stripe payment processing.
- **`admin/`**: React application using Vite for administration tasks (adding/listing food items, managing orders).

---

## 🛠️ Prerequisites

To run the application locally or on an EC2 instance, ensure the following are installed:
- **Node.js** (v18+ LTS recommended)
- **NPM** (v9+ recommended)
- **MongoDB Atlas Account** (or local MongoDB Community Server instance)
- **Stripe Account** (for test payment API keys)

---

## ⚙️ Environment Configuration Guide

To secure sensitive keys and enable seamless switching between development and production environments, config templates (`.env.example`) have been created. 

Create a `.env` file in each component directory and configure the variables accordingly:

### 1. Backend Config (`backend/.env`)
Create a file named `.env` in the `backend/` directory:
```env
# Server Port
PORT=4000

# Database Connection (MongoDB Atlas Connection URI)
MONGO_URL=mongodb+srv://<username>:<password>@cluster0.mongodb.net/food-delivery

# Security & Authentication
JWT_SECRET=your_jwt_secret_key_here
SALT=10

# Stripe Payment Gateway
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key_here

# Frontend URL (For Stripe Checkout redirects)
FRONTEND_URL=http://localhost:5173
```

### 2. Frontend Config (`frontend/.env`)
Create a file named `.env` in the `frontend/` directory:
```env
# API URL pointing to the Backend Server
VITE_BACKEND_URL=http://localhost:4000
```

### 3. Admin Panel Config (`admin/.env`)
Create a file named `.env` in the `admin/` directory:
```env
# API URL pointing to the Backend Server
VITE_BACKEND_URL=http://localhost:4000
```

---

## 🚀 Step-by-Step Installation & Run Guide

### Step 1: Install Dependencies
Open your terminal in the root directory and run:
```bash
# Install backend dependencies
cd backend
npm install

# Install frontend dependencies
cd ../frontend
npm install

# Install admin dependencies
cd ../admin
npm install
```

### Step 2: Start the Servers
Use three terminal sessions to run the components concurrently:

1. **Start Backend Server:**
   ```bash
   cd backend
   npm run server
   ```
   *Expected Output:* `Server Started on port: 4000` & `DB Connected`

2. **Start Frontend Client:**
   ```bash
   cd frontend
   npm run dev
   ```
   *Expected Output:* Vite dev server URL (typically `http://localhost:5173`)

3. **Start Admin Panel:**
   ```bash
   cd admin
   npm run dev
   ```
   *Expected Output:* Vite dev server URL (typically `http://localhost:5174` or similar)

---

## 🐞 Troubleshooting & Bug Fixes Log

Here are the key issues identified and fixed during testing and verification:

### Issue 1: Missing Node.js/NPM Environment
- **Symptoms:** Commands like `npm install` or `node server.js` return `command not found` or `The term 'npm' is not recognized`.
- **Cause:** Node.js runtime is either not installed or not added to the system `PATH` variable.
- **Solution:** 
  1. Download and run the Node.js installer from [Node.js Official Website](https://nodejs.org/).
  2. Select the option to add Node to PATH during installation.
  3. Close and reopen the terminal for changes to take effect.

### Issue 2: Hardcoded Production API URLs
- **Symptoms:** Running frontend/admin panels locally still sends requests to `https://food-delivery-backend-5b6g.onrender.com` instead of the local server. Any edits made locally on the backend are not reflected in the client.
- **Cause:** API endpoints were hardcoded to a specific Render server deployment.
- **Solution:** 
  - Refactored `frontend/src/context/StoreContext.jsx`, `admin/src/App.jsx`, and `admin/src/assets/assets.js` to use Vite environment variable: `import.meta.env.VITE_BACKEND_URL`.
  - Added a fallback string `"http://localhost:4000"` so that it resolves gracefully in local dev mode.

### Issue 3: Missing Environment Variable Templates
- **Symptoms:** Missing documentation on what keys need to be set up, leading to connection failures on startup or blank pages.
- **Cause:** The repository lacked `.env` files and `.env.example` templates.
- **Solution:** 
  - Added `backend/.env.example`, `frontend/.env.example`, and `admin/.env.example` templates.
  - Added safety checks in `backend/config/db.js` to log warning messages instead of crashing when `MONGO_URL` is undefined.

### Issue 4: ES Modules Import Ordering Bug (Dotenv Hoisting)
- **Symptoms:** Top-level variables (like `process.env.STRIPE_SECRET_KEY` in `orderController.js`) could resolve to `undefined` on start even when configured in `.env`.
- **Cause:** In `server.js`, `import "dotenv/config"` was ordered at line 6, after importing routers and databases. Since ES Modules hoist imports, this could cause other modules to evaluate before dotenv initialized variables.
- **Solution:** Moved `import "dotenv/config";` to the absolute top (line 1) of `backend/server.js`.

---

## 🌿 GitFlow Branching Strategy

To maintain a clean and reliable codebase, the project utilizes the following Git branches:

- **`main`**: Production-ready code. Matches the live environment.
- **`stg`**: Staging branch. Used for pre-production testing and QA.
- **`dev`**: Integration branch for development features.
- **`feature/<your-name>`**: Isolation branch for working on specific issues or features. (e.g., `feature/thabith12`)

### Workflow:
1. Work is done inside the feature branch (`feature/thabith12`).
2. Once verified, a Pull Request (PR) is created to merge changes into the `dev` branch.
3. After testing in `dev`, it is merged to `stg` for final checks before moving to `main`.
