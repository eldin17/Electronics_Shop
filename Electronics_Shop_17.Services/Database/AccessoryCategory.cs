using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Electronics_Shop_17.Services.Database
{
    public class AccessoryCategory : IHelperId, ISoftDelete
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool isDeleted { get; set; }

    }
}
