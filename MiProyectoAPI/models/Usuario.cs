using System.ComponentModel.DataAnnotations;

namespace MiProyectoAPI.Models
{
    public class Usuario
    {
        [Key]
        public int UsID { get; set; }
        public string NombreUsuario { get; set; }
        public string Email { get; set; }
        public string Contrasena { get; set; }
        public string Rol { get; set; }
        public bool Activo { get; set; } = true;
        public DateTime FechaCreacion { get; set; } = DateTime.Now;
    }

}
