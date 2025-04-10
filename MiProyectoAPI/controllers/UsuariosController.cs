using MiProyectoAPI.Data;
using MiProyectoAPI.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace MiProyectoAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsuariosController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public UsuariosController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        [Authorize(Roles = "admin")]
        public IActionResult Get()
        {
            return Ok(_context.Usuarios.ToList());
        }

        [HttpPost]
        [Authorize(Roles = "admin")]
        public IActionResult Post(Usuario nuevoUsuario)
        {
            if (_context.Usuarios.Any(u => u.Email == nuevoUsuario.Email))
            {
                return BadRequest("Este correo ya está registrado");
            }

            nuevoUsuario.Contrasena = BCrypt.Net.BCrypt.HashPassword(nuevoUsuario.Contrasena);
            nuevoUsuario.FechaCreacion = DateTime.Now;
            _context.Usuarios.Add(nuevoUsuario);
            _context.SaveChanges();

            return Ok(nuevoUsuario);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "admin")]
        public IActionResult Delete(int id)
        {
            var user = _context.Usuarios.Find(id);
            if (user == null) return NotFound();
            _context.Usuarios.Remove(user);
            _context.SaveChanges();
            return Ok();
        }
    }

}
