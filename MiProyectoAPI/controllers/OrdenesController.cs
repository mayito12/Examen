using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MiProyectoAPI.Data;
using MiProyectoAPI.Models;
using System.Security.Claims;

namespace MiProyectoAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class OrdenesController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public OrdenesController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetOrdenes()
        {
            int usuarioId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));
            var ordenes = _context.OrdenesDeServicio
                                  .Where(o => o.UsuarioCreo == usuarioId)
                                  .ToList();
            return Ok(ordenes);
        }

        [HttpPost]
        public IActionResult CrearOrden([FromBody] OrdenServicio orden)
        {
            int usuarioId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));

            bool cruza = _context.OrdenesDeServicio.Any(o =>
                o.UsuarioCreo == usuarioId &&
                o.Activo &&
                o.FechaFinal >= orden.FechaInicial &&
                o.FechaInicial <= orden.FechaFinal
            );

            if (cruza)
                return BadRequest("Las fechas se cruzan con otra orden activa del mismo usuario.");

            orden.UsuarioCreo = usuarioId;
            orden.FechaCreacion = DateTime.Now;

            _context.OrdenesDeServicio.Add(orden);
            _context.SaveChanges();

            return Ok(orden);
        }

        [HttpPut("{id}")]
        public IActionResult ActualizarOrden(int id, [FromBody] OrdenServicio updated)
        {
            var orden = _context.OrdenesDeServicio.Find(id);
            if (orden == null) return NotFound();

            int usuarioId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));
            if (orden.UsuarioCreo != usuarioId)
                return Forbid();

            // ✅ Validar si se quiere activar una orden, que no se cruce con otra activa del mismo usuario
            if (updated.Activo)
            {
                bool cruza = _context.OrdenesDeServicio.Any(o =>
                    o.UsuarioCreo == usuarioId &&
                    o.OrdenServicioID != id && // Excluir la misma orden
                    o.Activo &&
                    o.FechaFinal >= updated.FechaInicial &&
                    o.FechaInicial <= updated.FechaFinal
                );

                if (cruza)
                    return BadRequest("Las fechas se cruzan con otra orden activa del mismo usuario.");
            }

            orden.MunicipioID = updated.MunicipioID;
            orden.Colonia = updated.Colonia;
            orden.Domicilio = updated.Domicilio;
            orden.NumExterior = updated.NumExterior;
            orden.EntreCalles = updated.EntreCalles;
            orden.FechaInicial = updated.FechaInicial;
            orden.FechaFinal = updated.FechaFinal;
            orden.Activo = updated.Activo;

            _context.SaveChanges();
            return Ok(orden);
        }

        [HttpDelete("{id}")]
        public IActionResult EliminarOrden(int id)
        {
            var orden = _context.OrdenesDeServicio.Find(id);
            if (orden == null) return NotFound();

            int usuarioId = int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier));
            if (orden.UsuarioCreo != usuarioId)
                return Forbid();

            _context.OrdenesDeServicio.Remove(orden);
            _context.SaveChanges();
            return NoContent();
        }
    }

}
