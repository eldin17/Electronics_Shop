using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class UserNotificationService : BaseServiceCRUD<DtoUserNotification, UserNotification, SearchUserNotification, AddUserNotification, UpdateUserNotification>, IUserNotificationService
    {
        public UserNotificationService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<UserNotification> AddFilter(IQueryable<UserNotification> data, SearchUserNotification? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (search.UserAccountId != null)
            {
                data = data.Where(x => x.UserAccountId == search.UserAccountId);
            }
            if (search.NotificationId != null)
            {
                data = data.Where(x => x.NotificationId == search.NotificationId);
            }
            if (search.IsRead != null)
            {
                data = data.Where(x => x.IsRead == search.IsRead);
            }
            return base.AddFilter(data, search);
        }
    }
}
