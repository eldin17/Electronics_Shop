using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace Electronics_Shop_17.Middleware
{
    public class GlobalExceptionHandler : IExceptionHandler
    {
        private readonly ILogger<GlobalExceptionHandler> _logger;

        public GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger)
        {
            _logger = logger;
        }

        public async ValueTask<bool> TryHandleAsync(
            HttpContext httpContext,
            Exception exception,
            CancellationToken cancellationToken)
        {
            switch (exception)
            {
                case KeyNotFoundException:
                    _logger.LogWarning(exception, "KeyNotFoundException: {Message}", exception.Message);
                    httpContext.Response.StatusCode = StatusCodes.Status404NotFound;
                    await httpContext.Response.WriteAsJsonAsync(exception.Message, cancellationToken);
                    return true;

                case ArgumentException:
                    _logger.LogWarning(exception, "ArgumentException: {Message}", exception.Message);
                    httpContext.Response.StatusCode = StatusCodes.Status400BadRequest;
                    await httpContext.Response.WriteAsJsonAsync(exception.Message, cancellationToken);
                    return true;

                case UnauthorizedAccessException:
                    _logger.LogWarning(exception, "UnauthorizedAccessException: {Message}", exception.Message);
                    httpContext.Response.StatusCode = StatusCodes.Status401Unauthorized;
                    if (!string.IsNullOrEmpty(exception.Message))
                    {
                        await httpContext.Response.WriteAsJsonAsync(exception.Message, cancellationToken);
                    }
                    return true;

                default:
                    _logger.LogError(exception, "An unhandled exception occurred: {Message}", exception.Message);
                    httpContext.Response.StatusCode = StatusCodes.Status500InternalServerError;
                    var problemDetails = new ProblemDetails
                    {
                        Status = StatusCodes.Status500InternalServerError,
                        Title = "Internal Server Error",
                        Detail = "An unexpected error occurred while processing your request."
                    };
                    await httpContext.Response.WriteAsJsonAsync(problemDetails, cancellationToken);
                    return true;
            }
        }
    }
}