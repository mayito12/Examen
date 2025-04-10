using Microsoft.AspNetCore.Mvc;
using MiProyectoAPI.Data;

namespace MiProyectoAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MunicipiosController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public MunicipiosController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpGet("porEstado/{estadoId}")]
        public IActionResult GetMunicipiosPorEstado(int estadoId)
        {
            var municipios = _context.Municipios
                .Where(m => m.EstadoID == estadoId && m.Activo)
                .ToList();
            return Ok(municipios);
        }
    }
}