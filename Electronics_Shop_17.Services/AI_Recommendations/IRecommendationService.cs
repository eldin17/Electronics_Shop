using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Electronics_Shop_17.Model.DataTransferObjects;

namespace Electronics_Shop_17.Services.AI_Recommendations
{
    public interface IRecommendationService
    {
        Task<List<DtoProduct>> GetRecommendations(int customerId, int productId, int take = 3);
        void TrainModel();
    }
}
