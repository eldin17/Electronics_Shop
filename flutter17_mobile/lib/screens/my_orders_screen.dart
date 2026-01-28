import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/screens/payment_methods_select.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../providers/order_provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late List<Order> _ordersList = [];
  late OrderProvider _orderProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _orderProvider = context.read<OrderProvider>();
    initForm();
  }

  Future<void> initForm() async {
    try {
      var ordersObj = await _orderProvider.getAll(
        filter: {'customerId': LoginResponse.currentCustomer!.id},
      );

      if (ordersObj.data is List) {
        _ordersList = (ordersObj.data as List)
            .map((item) => item is Order ? item : Order.fromJson(item))
            .toList();

        _ordersList.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      } else {
        _ordersList = [];
      }
    } catch (e) {
      print('Error loading orders: $e');
      _ordersList = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showOrderModal(Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order #${order.id}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Total Amount: ${order.totalAmount}€'),
              Text(
                  'Final Total: ${order.finalTotalAmount ?? order.totalAmount}€'),
              Text(
                  'Order Time: ${DateFormat('dd-MMM-yy HH:mm').format(order.orderTime!)}'),
              const SizedBox(height: 10),
              const Divider(),
              const Text('Items',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...order.orderItems!.map((item) => ListTile(
                    title:
                        Text('${item.product!.brand!} ${item.product!.model!}'),
                    trailing: Text('${item.finalPrice}€'),
                  )),
              const SizedBox(height: 10),
              if (order.stateMachine == 'Pending')
                ElevatedButton(
                  onPressed: () async {
                    await _orderProvider.backToDraft(order.id!);
                    Navigator.pop(context);
                    // Navigate to your Stripe screen
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 150),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PaymentMethodsSelectScreen(draftOrder: order),
                      ),
                    );
                  },
                  child: const Text('Pay Now'),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_ordersList.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No orders found.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            const Text(
              "Your Orders",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${_ordersList.length} orders",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: _ordersList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () => _showOrderModal(_ordersList[index]),
              child: Card(
                color: Colors.white,
                shadowColor: Color.fromARGB(62, 105, 240, 175),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_bag,
                          size: 40, color: Colors.orangeAccent),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order #${_ordersList[index].id}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Total: ${_ordersList[index].finalTotalAmount ?? _ordersList[index].totalAmount}€",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 118, 67),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      _ordersList[index].stateMachine == 'Pending'
                          ? const Icon(Icons.warning, color: Colors.amberAccent)
                          : const Icon(Icons.check_circle,
                              color: Colors.greenAccent),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
