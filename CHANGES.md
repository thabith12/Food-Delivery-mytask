# Project Changes Log - Task 1

This document records the modifications made to the repository to enable local testing, configuration of environment variables, troubleshooting, and resolving evaluation order bugs.

---

## 📁 1. Backend Changes

### 🔧 [backend/server.js](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/backend/server.js)
* **Change:** Moved `import "dotenv/config";` to line 1.
* **Reason:** In ES Modules, imports are evaluated sequentially. Placing `dotenv` initialization at the top prevents environment variables from returning `undefined` when other imported router files evaluate.

### 🔌 [backend/config/db.js](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/backend/config/db.js)
* **Change:** Added a check for `process.env.MONGO_URL`.
* **Reason:** Warns the developer via console logging if the database URL is missing in the environment, rather than crashing with a generic mongoose connection error.

### 💳 [backend/controllers/orderController.js](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/backend/controllers/orderController.js)
* **Change:** Replaced the hardcoded Render URL for `frontend_url` with `process.env.FRONTEND_URL || "http://localhost:5173"`.
* **Reason:** Ensures Stripe payment redirects return to the local frontend site when testing locally, while remaining configurable on host deployments.

### 📄 [backend/.env.example](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/backend/.env.example) *(New File)*
* **Change:** Added an environment variables configuration template.

---

## 💻 2. Frontend Changes

### 🌐 [frontend/src/context/StoreContext.jsx](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/frontend/src/context/StoreContext.jsx)
* **Change:** Changed `url` variable from hardcoded Render address to `import.meta.env.VITE_BACKEND_URL || "http://localhost:4000"`.
* **Reason:** Permits the React app to communicate with a local backend server on Port 4000 instead of always calling production.

### 📄 [frontend/.env.example](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/frontend/.env.example) *(New File)*
* **Change:** Added a template highlighting `VITE_BACKEND_URL`.

---

## 🛡️ 3. Admin Panel Changes

### 🌐 [admin/src/App.jsx](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/admin/src/App.jsx)
* **Change:** Changed local `url` variable to `import.meta.env.VITE_BACKEND_URL || "http://localhost:4000"`.
* **Reason:** Makes the Admin React app request paths dynamic.

### 🌐 [admin/src/assets/assets.js](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/admin/src/assets/assets.js)
* **Change:** Changed exported assets `url` variable to use `import.meta.env.VITE_BACKEND_URL || "http://localhost:4000"`.
* **Reason:** Standardizes configuration fallback.

### 📄 [admin/.env.example](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/admin/.env.example) *(New File)*
* **Change:** Added a configuration template file.

---

## 📝 4. Documentation Changes

### 📘 [TROUBLESHOOTING.md](file:///c:/Users/ASUS/Desktop/Internship%20task/Food-Delivery-mytask/TROUBLESHOOTING.md) *(New File)*
* **Change:** Created a comprehensive local installation guide, step-by-step startup runbooks, environment setup parameters, and troubleshooting solutions.
