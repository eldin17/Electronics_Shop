using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Services.Interfaces;
using StackExchange.Redis;
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.ChatCompletion;
using Microsoft.SemanticKernel.Connectors.Ollama;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class SummaryAIService : ISummaryAIService
    {
        private readonly IChatCompletionService _chatCompletionService;
        private readonly IDatabase _redisDb;       
        private static readonly TimeSpan CacheDuration = TimeSpan.FromHours(24);
        private IReviewService _reviewService;
        private readonly OllamaPromptExecutionSettings _ollamaSettings;

        public SummaryAIService(Kernel kernel, IConnectionMultiplexer redis, IReviewService reviewService)
        {
            _chatCompletionService = kernel.GetRequiredService<IChatCompletionService>();
            _redisDb = redis.GetDatabase();
            _reviewService = reviewService;

            _ollamaSettings = new OllamaPromptExecutionSettings
            {
                Temperature = 0.2f
            };            
        }

        public async Task<string> GetOrCreateSummaryAsync(int productId, bool forceRefresh = false)
        {
            string cacheKey = $"product:{productId}:ai-summary";
            
            if (!forceRefresh)
            {
                string? cachedSummary = await _redisDb.StringGetAsync(cacheKey);
                if (!string.IsNullOrEmpty(cachedSummary))
                {
                    return cachedSummary; 
                }
            }

            var dbRes = await _reviewService.GetAll(new Model.SearchObjects.SearchReview { ProductId = productId });

            if (dbRes?.Data == null || !dbRes.Data.Any())
            {
                return "No reviews available yet for this product.";
            }

            List<string> reviews = dbRes.Data
                                .Select(r => r.Comment)
                                .Where(comment => !string.IsNullOrWhiteSpace(comment))
                                .ToList();

            if (!reviews.Any())
            {
                return "No written reviews available yet for this product.";
            }

            string newSummary = await GenerateSummaryFromLlmAsync(reviews);

            if (!newSummary.StartsWith("Review summary is temporarily unavailable") && !newSummary.StartsWith("AI Error:"))
            {
                await _redisDb.StringSetAsync(cacheKey, newSummary, CacheDuration);
            }

            return newSummary;
        }

        private async Task<string> GenerateSummaryFromLlmAsync(List<string> reviews)
        {
            var aggregatedReviews = string.Join("\n- ", reviews);
            var history = new ChatHistory();

            history.AddSystemMessage("You are an assistant that summarizes product reviews for an e-commerce store. Be concise, objective, and highlight the main pros and cons based *only* on the provided text. Keep responses short.");
            history.AddUserMessage($"Please summarize the following customer reviews:\n- {aggregatedReviews}");

            try
            {
                var response = await _chatCompletionService.GetChatMessageContentAsync(history, _ollamaSettings);
                return response.Content ?? "Could not generate summary.";
            }
            catch (Exception ex)
            {
                return $"AI Error: {ex.Message}. Inner: {ex.InnerException?.Message}";
            }
        }
    }
}
