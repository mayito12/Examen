import React from 'react';
import { useNavigate } from 'react-router-dom';

export default function Navbar() {
    const navigate = useNavigate();
    const usuario = JSON.parse(localStorage.getItem('usuario'));

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('usuario');
        navigate('/');
    };

    return (
        <nav style={styles.nav}>
            <span>Bienvenido, <strong>{usuario?.nombreUsuario || 'Usuario'}</strong></span>

            <div style={styles.actions}>
                {usuario?.rol === 'admin' && (
                    <button onClick={() => navigate('/usuarios')}>👥 Usuarios</button>
                )}

                <button onClick={handleLogout}>🚪 Cerrar sesión</button>
            </div>
        </nav>
    );
}

const styles = {
    nav: {
        padding: '10px 20px',
        background: '#f3f3f3',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center'
    },
    actions: {
        display: 'flex',
        gap: '10px'
    }
};
