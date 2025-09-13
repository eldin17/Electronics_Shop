using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Castle.Core.Resource;
using Electronics_Shop_17.Model.DataTransferObjects;
using Electronics_Shop_17.Model.Requests;
using Electronics_Shop_17.Model.SearchObjects;
using Electronics_Shop_17.Services.Database;
using Electronics_Shop_17.Services.InterfaceImplementations;
using Electronics_Shop_17.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Electronics_Shop_17.Services.OrderStateMachine
{
    public class InitialOrderState : BaseOrderState
    {
        IPaymentMethodService _paymentMethodService;
        IAdressService _adressService;
        Checks _checks;
        public InitialOrderState(DataContext context, IMapper mapper, IServiceProvider serviceProvider, IPaymentMethodService paymentMethodService, IAdressService adressService, Checks checks) : base(context, mapper, serviceProvider)
        {
            _paymentMethodService = paymentMethodService;
            _adressService = adressService;
            _checks = checks;
        }

        public override async Task<List<string>> AllowedActionsInState()
        {
            var actions = await base.AllowedActionsInState();
            actions.Add("Add");      
            return actions;
        }

        public async override Task<DtoOrder> AddByCart(AddByCartReq req)
        {
            var cartDb = await _context.Set<ShoppingCart>().Include(x=>x.CartItems).FirstOrDefaultAsync(x=>x.Id== req.CartId);
            var request = _mapper.Map<DtoShoppingCart>(cartDb);

            var addOrderObj = _mapper.Map<AddOrder>(request);

            if(req.CouponId!=null)
                addOrderObj.CouponId = req.CouponId;

            for (int i = 0; i < cartDb.CartItems.Count; i++)
            {
                addOrderObj.OrderItems[i].Price = cartDb.CartItems[i].Product.Price;
                addOrderObj.OrderItems[i].FinalPrice = await _checks.GetFinalPrice(addOrderObj.OrderItems[i].ProductId);
                addOrderObj.TotalAmount += addOrderObj.OrderItems[i].FinalPrice* addOrderObj.OrderItems[i].Quantity;
            }


            var (adressId,paymentMethodId) = GetIds(request).Result;
            addOrderObj.AdressId= adressId;
            addOrderObj.PaymentMethodId= paymentMethodId;
            
            var obj = _mapper.Map<Order>(addOrderObj);

            obj.StateMachine = "Draft";

            _context.Orders.Add(obj);

            await _context.SaveChangesAsync();

            return _mapper.Map<DtoOrder>(obj);

        }


        public async Task<(int,int)> GetIds(DtoShoppingCart request)
        {            
            var adressDb = await _context.Set<Adress>().FirstOrDefaultAsync(x => x.CustomerId == request.CustomerId);
            if (adressDb == null)
                throw new Exception("Adress not found");


            var paymentMethodDb = await _context.Set<PaymentMethod>().FirstOrDefaultAsync(x => x.CustomerId == request.CustomerId && x.IsDefault);
            
            if (paymentMethodDb == null)
            {
                var newPaymentMethod = new AddPaymentMethod()
                {
                    Type = "Cash on Delivery",
                    Provider = "Internal",
                    Key = "cash_cod",
                    ExpiryDate = DateTime.UtcNow.AddDays(3000),
                    IsDefault = true,
                    CustomerId = request.CustomerId,
                    isDeleted = false
                };

                var dto = await _paymentMethodService.Add(newPaymentMethod);
                paymentMethodDb.Id = dto.Id;
            }

            return (adressDb.Id,paymentMethodDb.Id);
        }
    }
}
