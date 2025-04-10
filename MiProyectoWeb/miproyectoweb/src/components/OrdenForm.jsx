import React, { useState, useEffect } from 'react';
import {
    TextField,
    Select,
    MenuItem,
    FormControl,
    InputLabel,
    Checkbox,
    FormControlLabel,
    Button,
    Grid,
    Paper,
    Typography
} from '@mui/material';
import api from '../api/api';

export default function OrdenForm({ orden = {}, onSubmit }) {
    const [estados, setEstados] = useState([]);
    const [municipios, setMunicipios] = useState([]);
    const [estadoID, setEstadoID] = useState(null);
    const [errores, setErrores] = useState({});

    const [form, setForm] = useState({
        municipioID: orden.municipioID || 0,
        colonia: orden.colonia || "",
        domicilio: orden.domicilio || "",
        numExterior: orden.numExterior || "",
        entreCalles: orden.entreCalles || "",
        fechaInicial: orden.fechaInicial?.slice(0, 10) || "",
        fechaFinal: orden.fechaFinal?.slice(0, 10) || "",
        activo: orden.activo ?? true
    });

    useEffect(() => {
        api.get('/Estados').then(res => setEstados(res.data));
    }, []);

    useEffect(() => {
        if (estadoID) {
            api.get(`/Municipios/porEstado/${estadoID}`).then(res => {
                setMunicipios(res.data);
            });
        }
    }, [estadoID]);

    const handleChange = e => {
        const { name, value, type, checked } = e.target;
        setForm(prev => ({
            ...prev,
            [name]: type === "checkbox" ? checked : value
        }));
    };

    const validarFormulario = () => {
        const nuevosErrores = {};
        if (!estadoID) nuevosErrores.estadoID = "El estado es obligatorio.";
        if (!form.municipioID) nuevosErrores.municipioID = "El municipio es obligatorio.";
        if (!form.colonia) nuevosErrores.colonia = "La colonia es obligatoria.";
        if (!form.fechaInicial || !form.fechaFinal) {
            nuevosErrores.fechas = "Las fechas son obligatorias.";
        } else if (form.fechaFinal < form.fechaInicial) {
            nuevosErrores.fechas = "La fecha final no puede ser menor a la inicial.";
        }
        setErrores(nuevosErrores);
        return Object.keys(nuevosErrores).length === 0;
    };

    const handleSubmit = e => {
        e.preventDefault();
        if (!validarFormulario()) return;
        onSubmit(form);
    };

    return (
        <Paper sx={{ padding: 4, marginTop: 4 }}>
            <Typography variant="h6" gutterBottom>
                {orden.ordenServicioID ? 'Editar Orden de Servicio' : 'Nueva Orden de Servicio'}
            </Typography>
            <form onSubmit={handleSubmit}>
                <Grid container spacing={2}>
                    <Grid item xs={12} sm={6}>
                        <FormControl fullWidth>
                            <InputLabel>Estado</InputLabel>
                            <Select value={estadoID || ''} label="Estado" onChange={(e) => setEstadoID(e.target.value)}>
                                {estados.map(e => (
                                    <MenuItem key={e.estadoID} value={e.estadoID}>{e.estadoNombre}</MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <FormControl fullWidth>
                            <InputLabel>Municipio</InputLabel>
                            <Select name="municipioID" value={form.municipioID} label="Municipio" onChange={handleChange}>
                                {municipios.map(m => (
                                    <MenuItem key={m.municipioID} value={m.municipioID}>{m.municipioNombre}</MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField name="colonia" label="Colonia" fullWidth value={form.colonia} onChange={handleChange} />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField name="domicilio" label="Domicilio" fullWidth value={form.domicilio} onChange={handleChange} />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField name="numExterior" label="Número exterior" fullWidth value={form.numExterior} onChange={handleChange} />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField name="entreCalles" label="Entre calles" fullWidth value={form.entreCalles} onChange={handleChange} />
                    </Grid>

                    <Grid item xs={12} sm={6}>
                        <TextField name="fechaInicial" label="Fecha inicial" type="date" InputLabelProps={{ shrink: true }} fullWidth value={form.fechaInicial} onChange={handleChange} />
                    </Grid>
                    <Grid item xs={12} sm={6}>
                        <TextField name="fechaFinal" label="Fecha final" type="date" InputLabelProps={{ shrink: true }} fullWidth value={form.fechaFinal} onChange={handleChange} />
                    </Grid>

                    <Grid item xs={12}>
                        <FormControlLabel control={<Checkbox name="activo" checked={form.activo} onChange={handleChange} />} label="Activa" />
                    </Grid>

                    <Grid item xs={12}>
                        <Button type="submit" variant="contained" color="primary">
                            {orden.ordenServicioID ? 'Actualizar' : 'Guardar'}
                        </Button>
                    </Grid>
                </Grid>
            </form>
        </Paper>
    );
}


