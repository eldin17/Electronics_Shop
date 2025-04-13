import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/discount.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/models/news.dart' as Model;
import 'package:flutter17_mobile/providers/discount_provider.dart';
import 'package:flutter17_mobile/providers/news_provider.dart';
import 'package:flutter17_mobile/providers/notification_provider.dart';
import 'package:flutter17_mobile/providers/product_provider.dart';
import 'package:flutter17_mobile/screens/news_details_screen.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/screens/products_screen.dart';
import 'package:flutter17_mobile/screens/test.dart';
import 'package:flutter17_mobile/widgets/btn_counter.dart';
import 'package:flutter17_mobile/widgets/categories.dart';
import 'package:flutter17_mobile/widgets/discount.dart';
import 'package:flutter17_mobile/widgets/discount_products.dart';
import 'package:flutter17_mobile/widgets/latest_products.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter17_mobile/models/notification.dart' as Model_n;

import '../widgets/news_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productsList = [];
  List<Product> latestProductsList = [];
  List<Product> discountProductsList = [];
  late Discount discountExample;

  List<Model.News> newsList = [];
  late ProductProvider _productProvider;
  late NewsProvider _newsProvider;
  late DiscountProvider _discountProvider;

  bool isLoading = true;
  TextEditingController searchController = new TextEditingController();
  bool isNotificationVisible = false;
  bool isNewsDetailsVisible = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productProvider = context.read<ProductProvider>();
    _newsProvider = context.read<NewsProvider>();
    _discountProvider = context.read<DiscountProvider>();

    initForm();
  }

  Future initForm() async {
    //var productsObj = await _productProvider.getAll();
    var productsObj = await _productProvider
        .getAllWithChecks(LoginResponse.currentCustomer!.id!);

    var newsObj = await _newsProvider.getAll();
    var discountObj = await _discountProvider.getOneRandom();

    setState(() {
      productsList = List<Product>.from(productsObj.data);
      newsList = List<Model.News>.from(newsObj.data);
      discountExample = discountObj;
      latestProductsList = List<Product>.from(productsList);
      discountProductsList = List<Product>.from(productsList);

      latestProductsList.sort((a, b) => b.id!.compareTo(a.id!));
      discountProductsList = List<Product>.from(discountProductsList
          .where((element) => element.finalPrice != element.price));
      isLoading = false;
    });
    print("******FROM HOME SCREEN******");
    print(LoginResponse.token);
    print(LoginResponse.userId);
    print(LoginResponse.roleName);
    print("customer - ${LoginResponse.isCustomer}");
    print("seller - ${LoginResponse.isSeller}");
    print("current - ${LoginResponse.currentCustomer?.id}");
    print("discount - ${discountExample.amount}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? LoadingScreen()
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        HomeHeader(
                          isClicked: isNotificationVisible,
                          showInfo: () {
                            setState(() {
                              isNotificationVisible = !isNotificationVisible;
                            });
                            print(isNotificationVisible);
                          },
                          searchController: searchController,
                        ),
                        DiscountBanner(obj: discountExample),
                        LatestProducts(
                          products: latestProductsList,
                        ),
                        Categories(),
                        News(list: newsList),
                        SizedBox(height: 20),
                        DiscountProducts(
                          products: discountProductsList,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    isNotificationVisible
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 65, 0, 0),
                              child: NotificationDropdown(),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
    );
  }
}

class NotificationDropdown extends StatefulWidget {
  NotificationDropdown({super.key});

  @override
  _NotificationDropdownState createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 50),
      opacity: isVisible ? 1.0 : 0.0,
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 53, 53, 53).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 4), // Soft drop shadow
            ),
          ],
        ),
        child: const NotificationList(),
      ),
    );
  }
}

class HomeHeader extends StatefulWidget {
  TextEditingController searchController;
  Function showInfo;
  bool isClicked;

  HomeHeader(
      {super.key,
      required this.searchController,
      required this.showInfo,
      required this.isClicked});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late NotificationProvider _notificationProvider;
  List<Model_n.Notification> notificationsList = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationProvider = context.read<NotificationProvider>();

    initForm();
  }

  Future initForm() async {
    var notification =
        await _notificationProvider.getAllForUser(LoginResponse.userId ?? 0);

    setState(() {
      notificationsList = List<Model_n.Notification>.from(notification.data);

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SearchField(searchController: widget.searchController)),
          const SizedBox(width: 24),
          IconBtnWithCounter(
            onClickColor: true,
            isClicked: widget.isClicked,
            svgSrc: bellIcon,
            numOfitem: notificationsList.length,
            press: () {
              setState(() {
                notificationsList.length = 0;
                widget.showInfo();
              });
            },
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  TextEditingController searchController;

  SearchField({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        onFieldSubmitted: (value) {
          print(value);
          Navigator.of(context)
              .push(
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
                  ProductsScreen(
                searchBox: value,
                showScreenIfEmpty: true,
              ),
            ),
          )
              .then((_) {
            searchController.value = TextEditingValue.empty;
          });
        },
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          fillColor: const Color(0xFF979797).withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          hintText: "Search products",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
