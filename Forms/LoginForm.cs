using System.ComponentModel.DataAnnotations;

namespace CompanyKnowledgeAIClient.Forms;

/// <summary>
/// Represents the form data for user login.
/// </summary>
internal class LoginForm
{
    /// <summary>
    /// Gets or sets the username.
    /// This field is required.
    /// </summary>
    [Required]
    public string Username { get; set; }

    /// <summary>
    /// Gets or sets the password.
    /// This field is required and must be at least 4 characters long.
    /// </summary>
    [Required]
    [StringLength(30, ErrorMessage = "Password must be at least 4 characters long.", MinimumLength = 4)]
    public string Password { get; set; }
}