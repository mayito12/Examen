import React from 'react';
import { Link } from 'react-router-dom';

export default function AccesoDenegado() {
    return (
        <div style={{ padding: '2rem' }}>
            <h2>🚫 Acceso denegado</h2>
            <p>No tienes permisos para ver esta página.</p>
            <Link to="/ordenes">Volver al inicio</Link>
        </div>
    );
}
