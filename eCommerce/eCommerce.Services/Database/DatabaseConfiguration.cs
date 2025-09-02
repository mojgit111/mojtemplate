using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Mapster;

namespace eCommerce.Services.Database
{
    public static class DatabaseConfiguration
    {
        public static void AddDatabaseServices(this IServiceCollection services, string connectionString)
        {
            services.AddDbContext<eCommerceDbContext>(options =>
                options.UseSqlServer(connectionString));
                
            // Configure Mapster mappings
        }

        public static void AddDatabaseEComm(this IServiceCollection services, string connectionString)
        {
            services.AddDbContext<eCommerceDbContext>(options =>
                options.UseSqlServer(connectionString));
        }
        
      
    }
} 