import React, { useEffect, useState } from 'react';
import api from '../api/api';
import Navbar from '../components/Navbar';
import {
    Container,
    Typography,
    TextField,
    Button,
    Paper,
    Grid,
    MenuItem,
    Select,
    InputLabel,
    FormControl,
    Box,
    IconButton,
    List,
    ListItem,
    ListItemText,
    ListItemSecondaryAction
} from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';

export default function UsuariosPage() {
    const [usuarios, setUsuarios] = useState([]);
    const [form, setForm] = useState({
        nombreUsuario: '',
        email: '',
        contrasena: '',
        rol: 'usuario',
        activo: true
    });

    const cargarUsuarios = async () => {
        const res = await api.get('/Usuarios');
        setUsuarios(res.data);
    };

    const crearUsuario = async (e) => {
        e.preventDefault();
        await api.post('/Usuarios', form);
        setForm({ nombreUsuario: '', email: '', contrasena: '', rol: 'usuario', activo: true });
        cargarUsuarios();
    };

    const eliminarUsuario = async (id) => {
        if (confirm("¿Eliminar este usuario?")) {
            await api.delete(`/Usuarios/${id}`);
            cargarUsuarios();
        }
    };

    useEffect(() => {
        cargarUsuarios();
    }, []);

    return (
        <>
            <Navbar />
            <Container maxWidth="md">
                <Typography variant="h4" gutterBottom sx={{ mt: 4 }}>Administrar Usuarios</Typography>

                <Paper sx={{ padding: 3, marginBottom: 4 }}>
                    <Typography variant="h6" gutterBottom>Nuevo Usuario</Typography>
                    <Box component="form" onSubmit={crearUsuario}>
                        <Grid container spacing={2}>
                            <Grid item xs={12} sm={6}>
                                <TextField label="Nombre" fullWidth value={form.nombreUsuario} onChange={e => setForm({ ...form, nombreUsuario: e.target.value })} />
                            </Grid>
                            <Grid item xs={12} sm={6}>
                                <TextField label="Email" type="email" fullWidth value={form.email} onChange={e => setForm({ ...form, email: e.target.value })} />
                            </Grid>
                            <Grid item xs={12} sm={6}>
                                <TextField label="Contraseña" type="password" fullWidth value={form.contrasena} onChange={e => setForm({ ...form, contrasena: e.target.value })} />
                            </Grid>
                            <Grid item xs={12} sm={6}>
                                <FormControl fullWidth>
                                    <InputLabel>Rol</InputLabel>
                                    <Select value={form.rol} label="Rol" onChange={e => setForm({ ...form, rol: e.target.value })}>
                                        <MenuItem value="usuario">Usuario</MenuItem>
                                        <MenuItem value="admin">Administrador</MenuItem>
                                    </Select>
                                </FormControl>
                            </Grid>
                            <Grid item xs={12}>
                                <Button type="submit" variant="contained">Crear</Button>
                            </Grid>
                        </Grid>
                    </Box>
                </Paper>

                <Typography variant="h6" gutterBottom>Lista de Usuarios</Typography>
                <List>
                    {usuarios.map(u => (
                        <ListItem key={u.usID} divider>
                            <ListItemText primary={`${u.nombreUsuario} (${u.rol})`} secondary={u.email} />
                            <ListItemSecondaryAction>
                                <IconButton edge="end" aria-label="delete" onClick={() => eliminarUsuario(u.usID)}>
                                    <DeleteIcon />
                                </IconButton>
                            </ListItemSecondaryAction>
                        </ListItem>
                    ))}
                </List>
            </Container>
        </>
    );
}
