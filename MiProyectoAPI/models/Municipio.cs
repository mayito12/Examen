using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace MiProyectoAPI.Models
{
    public class Municipio
    {
        [Key]
        public int MunicipioID { get; set; }
        public int EstadoID { get; set; }
        [Column("Municipio")] 
        public string MunicipioNombre { get; set; }
        public bool Activo { get; set; }
        public Estado Estado { get; set; }
    }
}
