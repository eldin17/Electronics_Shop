using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ML.Data;

namespace Electronics_Shop_17.Services.AI_Recommendations
{
    public class ProductEntry
    {
        [KeyType(count: 10000)]
        public uint ProductID { get; set; }

        [KeyType(count: 10000)]
        public uint CoPurchaseProductID { get; set; }

        public float Label { get; set; }
    }
}
