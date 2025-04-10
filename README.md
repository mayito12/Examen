# 📦 Proyecto CRUD - ReactJS + .NET Core + SQL Server

Este es un sistema CRUD completo para gestionar órdenes de servicio, usuarios, estados y municipios. Utiliza:

- ⚙️ Backend en .NET Core
- 💻 Frontend en ReactJS (con Vite)
- 🗄 Base de datos SQL Server
- 🔐 Autenticación JWT
- 🎨 Interfaz con Material UI (MUI)

---

## ✅ Requisitos

### Para backend (.NET Core):
- [.NET SDK 7 o 6](https://dotnet.microsoft.com/en-us/download)
- SQL Server o SQL Express

### Para frontend (React):
- [Node.js](https://nodejs.org/) y npm

---

## 🧪 Instrucciones para correr el proyecto

### 🔧 Backend (API .NET Core)

1. Abre una terminal en la carpeta del proyecto (`MiProyectoAPI`)
2. Verifica la cadena de conexión en `appsettings.json`:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=localhost;Database=ProyectoCrud;Trusted_Connection=True;TrustServerCertificate=True;"
}
```
3. Ejecuta el backend:
```bash
dotnet run
```
6. Accede a Swagger: [https://localhost:7108/swagger](https://localhost:7108/swagger)

### 🌐 Frontend (React + MUI)

1. Abre una terminal en la carpeta del frontend 
2. Instala dependencias:
```bash
npm install
```
3. Ejecuta la app:
```bash
npm run dev
```
4. Accede desde: [http://localhost:5173](http://localhost:5173)

---

## 🔐 Datos de acceso 
Roles disponibles:
- `usuario`
- `admin` PARA ENTRAR A ADMIN VIENE CON EMAIL: "mario@gmail.com" y contraseña "mario12"


## 📦 Paquetes usados

### Backend:
- `Microsoft.AspNetCore.Authentication.JwtBearer`
- `Microsoft.AspNetCore.Mvc.NewtonsoftJson`
- `Microsoft.EntityFrameworkCore.SqlServer`

### Frontend:
- React + Vite
- Axios
- React Router
- Material UI (`@mui/material`)

---
## ✨ Autor
Mario Arturo 
---
