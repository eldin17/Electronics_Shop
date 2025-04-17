using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Helpers;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Electronics_Shop_17.Services.InterfaceImplementations
{
    public class NotificationService : BaseServiceCRUD<DtoNotification, Notification, SearchNotification, AddNotification, UpdateNotification>, INotificationService
    {
        IUserNotificationService _IUserNotificationService;
        public NotificationService(DataContext context, IMapper mapper, IUserNotificationService IUserNotificationService) : base(context, mapper)
        {
            _IUserNotificationService = IUserNotificationService;
        }

        public async Task<DtoNotification> AddForUser(AddNotificationForUser addRequest)
        {
            if (addRequest!=null && addRequest.userAccIds!=null)
            {
                var addObj = _mapper.Map<AddNotification>(addRequest);
                var obj = await Add(addObj);
                if (obj!=null && obj.IsGeneral)
                {
                    var users = await _context.UserAccounts.Where(x => x.Role.RoleName == "Customer" && !x.isDeactivated).Select(x=>x.Id).ToListAsync();
                    foreach (var item in users)
                    {
                        var newObj = new AddUserNotification()
                        {
                            UserAccountId = item,
                            NotificationId = obj.Id,
                            IsRead = false
                        };
                        await _IUserNotificationService.Add(newObj);
                    }
                }
                else
                {
                    foreach (var item in addRequest.userAccIds)
                    {
                        var newObj = new AddUserNotification()
                        {
                            UserAccountId = item,
                            NotificationId = obj.Id,
                            IsRead = false
                        };
                        await _IUserNotificationService.Add(newObj);
                    }
                }
                await _context.SaveChangesAsync();
                return obj;
            }
            var addObjDefault = _mapper.Map<AddNotification>(addRequest);
            return await Add(addObjDefault);
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

        public async Task<Pagination<DtoNotification>> GetAllForUser(int userAccountId, SearchNotification search = null)
        {
            if (userAccountId != 0)
            {
                var idList = await _context.UserNotifications.Where(x => x.UserAccountId == userAccountId && x.IsRead==false).Select(x=>x.NotificationId).ToListAsync();

                if (!idList.IsNullOrEmpty())
                {            
                    var notifications = _context.Notifications.Where(x => idList.Contains(x.Id)).AsQueryable();

                    if(notifications != null && notifications.Any())
                    {
                        notifications = AddFilter(notifications, search);
                        notifications = AddInclude(notifications);

                        var totalItems = await notifications.CountAsync();                  
                       
                        
                        if (search?.PageNumber.HasValue == true && search?.ItemsPerPage.HasValue == true)
                        {
                            notifications = notifications
                                .Skip((search.PageNumber.Value - 1) * search.ItemsPerPage.Value)
                                .Take(search.ItemsPerPage.Value);
                        }

                        var toList = await notifications.ToListAsync();
                        var list = _mapper.Map<List<DtoNotification>>(toList);

                        return new Pagination<DtoNotification>(list, totalItems);
                        
                    }
                }
            }
            return new Pagination<DtoNotification>(data: [],totalItems: 0);
        }

        public async Task<string> MarkAsRead(int userAccId, int notificationId)
        {
            var obj = await _context.UserNotifications.FirstOrDefaultAsync(x => x.UserAccountId == userAccId && x.NotificationId == notificationId);
            if (obj != null) { 
                obj.IsRead = !obj.IsRead;
                await _context.SaveChangesAsync();
                return "Success";
            }
            return "Fail";
        }
    }
}
