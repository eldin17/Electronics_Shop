using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;

namespace Electronics_Shop_17.Services.SignalR
{
    [Authorize]
    public class NotificationHub : Hub
    {
    }
}
