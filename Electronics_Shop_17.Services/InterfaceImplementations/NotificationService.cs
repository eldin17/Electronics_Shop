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
    public class NotificationService : BaseServiceCRUD<DtoNotification, Notification, SearchNotification, AddNotification, UpdateNotification>, INotificationService
    {
        public NotificationService(DataContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Notification> AddFilter(IQueryable<Notification> data, SearchNotification? search)
        {
            if (search.Id != null)
            {
                data = data.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search.Title))
            {
                data = data.Where(x => x.Title.Contains(search.Title));
            }
            if (!string.IsNullOrWhiteSpace(search.Message))
            {
                data = data.Where(x => x.Message.Contains(search.Message));
            }
            if (search.DateCreated != null)
            {
                data = data.Where(x => x.DateCreated == search.DateCreated);
            }
            if (search.IsGeneral != null)
            {
                data = data.Where(x => x.IsGeneral == search.IsGeneral);
            }
            return base.AddFilter(data, search);
        }
    }
}
