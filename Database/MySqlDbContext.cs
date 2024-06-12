using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace CompanyKnowledgeAILogic.MySqlDatabase
{
    public class MySqlDbContext : IdentityDbContext<IdentityUser>
    {
        private readonly IConfiguration _configuration;

        public MySqlDbContext(DbContextOptions<MySqlDbContext> options, IConfiguration configuration)
            : base(options)
        {
            _configuration = configuration;
            // require explicit cascade delete configuration or call to CascadeChanges()
            ChangeTracker.CascadeDeleteTiming = CascadeTiming.Never;
            ChangeTracker.DeleteOrphansTiming = CascadeTiming.Never;
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseMySQL(_configuration["MySql:ConnectionString"]);
        }
    }
}
