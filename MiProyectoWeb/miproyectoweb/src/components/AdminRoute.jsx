import React from 'react';
import { Navigate } from 'react-router-dom';

export default function AdminRoute({ children }) {
    const token = localStorage.getItem('token');
    const usuario = JSON.parse(localStorage.getItem('usuario'));

    const esAdmin = token && usuario?.rol === 'admin';

    return esAdmin ? children : <Navigate to="/denegado" />;
}
