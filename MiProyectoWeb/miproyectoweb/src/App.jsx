import { BrowserRouter, Routes, Route } from 'react-router-dom';
import LoginPage from './pages/LoginPage';
import OrdenesPage from './pages/OrdenesPage';
import AccesoDenegado from './pages/AccesoDenegado';
import PrivateRoute from './components/PrivateRoute';
import UsuariosPage from './pages/UsuariosPage';
import AdminRoute from './components/AdminRoute';

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<LoginPage />} />
                <Route path="/usuarios" element={
                    <AdminRoute>
                        <UsuariosPage />
                    </AdminRoute>
                } />
                <Route path="/denegado" element={<AccesoDenegado />} />
                <Route path="/ordenes" element={
                    <PrivateRoute>
                        <OrdenesPage />
                    </PrivateRoute>
                } />
            </Routes>
        </BrowserRouter>
    );
}

export default App;
