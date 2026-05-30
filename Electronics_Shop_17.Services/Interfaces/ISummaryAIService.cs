using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Interfaces
{
    public interface ISummaryAIService
    {
        Task<string> GetOrCreateSummaryAsync(int productId, bool forceRefresh = false);
    }
}
