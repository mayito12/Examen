using Microsoft.AspNetCore.Mvc;
using MiProyectoAPI.Data;

namespace MiProyectoAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EstadosController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public EstadosController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetEstados()
        {
            var estados = _context.Estados.Where(e => e.Activo).ToList();
            return Ok(estados);
        }
    }
}