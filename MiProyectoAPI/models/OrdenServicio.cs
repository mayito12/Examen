using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;



namespace MiProyectoAPI.Models
{
    public class OrdenServicio
    {
        [Key]
        public int OrdenServicioID { get; set; }
        public int MunicipioID { get; set; }
        public string Colonia { get; set; }

        public string Domicilio { get; set; }

        public string NumExterior { get; set; }
        public string EntreCalles { get; set; }
        public DateTime FechaInicial { get; set; }
        public DateTime FechaFinal { get; set; }
        public bool Activo { get; set; }
        public int UsuarioCreo { get; set; }
        public DateTime FechaCreacion { get; set; }


    }
}
