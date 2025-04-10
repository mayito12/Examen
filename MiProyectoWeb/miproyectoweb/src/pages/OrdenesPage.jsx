import React, { useEffect, useState } from 'react';
import api from '../api/api';
import OrdenForm from '../components/OrdenForm';
import {
    Container,
    Typography,
    Button,
    Card,
    CardContent,
    CardActions,
    Grid,
    Box
} from '@mui/material';
import Navbar from '../components/Navbar';


export default function OrdenesPage() {
    const [ordenes, setOrdenes] = useState([]);
    const [mostrarForm, setMostrarForm] = useState(false);
    const [editar, setEditar] = useState(null);

    const cargarOrdenes = async () => {
        const res = await api.get('/Ordenes');
        setOrdenes(res.data);
    };

    const crearOrden = async (nuevaOrden) => {
        try {
            await api.post('/Ordenes', nuevaOrden);
            setMostrarForm(false);
            cargarOrdenes();
        } catch (err) {
            alert(err.response?.data || 'Error al crear la orden');
        }
    };


    const actualizarOrden = async (actualizada) => {
        try {
            await api.put(`/Ordenes/${editar.ordenServicioID}`, actualizada);
            setEditar(null);
            cargarOrdenes();
        } catch (err) {
            alert(err.response?.data || 'Error al actualizar la orden');
        }
    };
    const eliminarOrden = async (id) => {
        if (confirm("¿Eliminar esta orden?")) {
            await api.delete(`/Ordenes/${id}`);
            cargarOrdenes();
        }
    };


    useEffect(() => {
        cargarOrdenes();
    }, []);

    return (

        <>
            <Navbar />
            <Container maxWidth="md">
                <Typography variant="h4" gutterBottom sx={{ mt: 4 }}>Órdenes de Servicio</Typography>
                <Box mb={3}>
                    <Button variant="contained" onClick={() => setMostrarForm(true)}>+ Nueva Orden</Button>
                </Box>

                {mostrarForm && <OrdenForm onSubmit={crearOrden} />}
                {editar && <OrdenForm orden={editar} onSubmit={actualizarOrden} />}

                <Grid container spacing={2}>
                    {ordenes.map(o => (
                        <Grid item xs={12} key={o.ordenServicioID}>
                            <Card variant="outlined">
                                <CardContent>
                                    <Typography variant="h6">{o.colonia}</Typography>
                                    <Typography color="text.secondary">
                                        {o.domicilio}, {o.numExterior} — del {o.fechaInicial?.slice(0, 10)} al {o.fechaFinal?.slice(0, 10)}
                                    </Typography>
                                    <Typography variant="body2">Entre calles: {o.entreCalles}</Typography>
                                </CardContent>
                                <CardActions>
                                    <Button size="small" onClick={() => setEditar(o)}>Editar</Button>
                                    <Button size="small" color="error" onClick={() => eliminarOrden(o.ordenServicioID)}>Eliminar</Button>
                                </CardActions>
                            </Card>
                        </Grid>
                    ))}
                </Grid>
            </Container>
        </>
    );
}
