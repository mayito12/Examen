using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace MiProyectoAPI.Models
{
    public class Estado
    {
        [Key]
        public int EstadoID { get; set; }

        [Column("Estado")]
        public string EstadoNombre { get; set; } = string.Empty;
        public bool Activo { get; set; }
    }
}
