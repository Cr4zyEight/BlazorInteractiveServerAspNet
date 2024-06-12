using BlazorInteractiveServerAspNet.Components;
using CompanyKnowledgeAILogic.MySqlDatabase;
using Microsoft.AspNetCore.Identity;
using MudBlazor.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents()
    .AddCircuitOptions(options => { options.DetailedErrors = true; }); // datailed error output on circuit

builder.Services.AddMudServices();

// My Sql DbContext
builder.Services.AddDbContext<MySqlDbContext>();

// Authentication
builder.Services.AddCascadingAuthenticationState(); 
builder.Services.AddAuthentication(options => {
    options.DefaultScheme = IdentityConstants.ApplicationScheme; 
    options.DefaultSignInScheme = IdentityConstants.ExternalScheme;
})
.AddIdentityCookies();

// Identity
builder.Services.AddIdentityCore<IdentityUser>(options =>
        {
            // Create user settings for Debug ONLY 
            options.SignIn.RequireConfirmedAccount = false;
            options.User.RequireUniqueEmail = false;
            options.Password.RequireDigit = false;
            options.Password.RequireLowercase = false;
            options.Password.RequireNonAlphanumeric = false;
            options.Password.RequireUppercase = false;
            options.Password.RequiredLength = 1; // Set to 1 for the shortest possible password
            options.Password.RequiredUniqueChars = 0;
        }
    )
    .AddEntityFrameworkStores<MySqlDbContext>()
    .AddSignInManager()
    .AddDefaultTokenProviders();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
