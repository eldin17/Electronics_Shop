import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/providers/product_provider.dart';
import 'package:flutter17_mobile/screens/home_screen.dart';
import 'package:flutter17_mobile/screens/no_products.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
// TODO: add flutter_svg package to pubspec.yaml
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  String searchBox;
  bool fromLatest;
  bool fromOnDiscount;

  String category;

  ProductsScreen({
    super.key,
    this.fromLatest = false,
    this.fromOnDiscount = false,
    this.category = "",
    this.searchBox = "",
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> productsList = [];
  late ProductProvider _productProvider;
  List<Product> latestProductsList = [];
  List<Product> discountProductsList = [];
  List<Product> listProducts = [];
  bool isLoading = true;
  bool filterSectionVisibility = false;
  Set<String> _selectedCategories = {};

  TextEditingController _searchController = new TextEditingController();
  TextEditingController _priceLowController = new TextEditingController();
  TextEditingController _priceHighController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();

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
    initForm();
  }

  Future initForm() async {
    //filter za searchBox sa homeScreen
    var productsObj = await _productProvider.getAllWithChecks(LoginResponse.currentCustomer!.id!,filter: {
      'fullTextSearch': widget.searchBox,
    });
    print("hepekekekekeek ${widget.searchBox}");

    setState(() {
      if (widget.searchBox != "") _searchController.text = widget.searchBox;
      productsList = List<Product>.from(productsObj.data);

      latestProductsList = List<Product>.from(productsList);
      discountProductsList = List<Product>.from(productsList);

      latestProductsList.sort((a, b) => b.id!.compareTo(a.id!));
      discountProductsList = List<Product>.from(discountProductsList
          .where((element) => element.finalPrice != element.price));

      if (widget.category.length > 0) {
        widget.fromLatest = false;
        widget.fromOnDiscount = false;

        productsList = productsList
            .where((element) =>
                element.productCategory!.name ==
                categoryNameSelect2(widget.category))
            .toList();
      }

      listProducts = widget.fromLatest
          ? latestProductsList
          : widget.fromOnDiscount
              ? discountProductsList
              : productsList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return listProducts.length > 0
        ? !isLoading
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Center(child: const Text("Products")),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        backgroundColor: const Color(0xFFF5F6F9),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          child: IconBtn(
                            svgSrc: filterIcon,
                            press: () {
                              setState(() {
                                filterSectionVisibility =
                                    !filterSectionVisibility;
                              });
                            },
                          )),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filterSectionVisibility
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: SearchField(
                                        searchController: _searchController,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: PriceLow(
                                            priceLowController:
                                                _priceLowController,
                                          ),
                                        )),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: PriceHigh(
                                            priceHighController:
                                                _priceHighController,
                                          ),
                                        )),
                                      ],
                                    ),
                                    CategoriesFilter(
                                      selectedCategories: _selectedCategories,
                                    ),
                                    _searchController.value.text != "" ||
                                            _priceHighController.value.text !=
                                                "" ||
                                            _priceLowController.value.text !=
                                                "" ||
                                            _selectedCategories.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: Color.fromARGB(
                                                    255, 155, 155, 155),
                                                foregroundColor: Colors.white,
                                                minimumSize: const Size(
                                                    double.infinity, 48),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16)),
                                                ),
                                              ),
                                              onPressed: () async {
                                                var response =
                                                    await _productProvider
                                                        .getAll();

                                                setState(() {
                                                  listProducts =
                                                      List<Product>.from(
                                                          response.data);
                                                  _searchController.value =
                                                      TextEditingValue.empty;
                                                  _priceHighController.value =
                                                      TextEditingValue.empty;
                                                  _priceLowController.value =
                                                      TextEditingValue.empty;
                                                  _selectedCategories =
                                                      new Set<String>();
                                                });
                                              },
                                              child:
                                                  const Text("Reset filters"),
                                            ),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              const Color(0xFFFF7643),
                                          foregroundColor: Colors.white,
                                          minimumSize:
                                              const Size(double.infinity, 48),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16)),
                                          ),
                                        ),
                                        onPressed: () async {
                                          var priceHigh;
                                          var priceLow;
                                          if (_priceHighController.text != "") {
                                            try {
                                              priceHigh = double.parse(
                                                  _priceHighController.text);
                                            } catch (e) {
                                              priceHigh = 0;
                                            }
                                          }
                                          if (_priceLowController.text != "") {
                                            try {
                                              priceLow = double.parse(
                                                  _priceLowController.text);
                                            } catch (e) {
                                              priceLow = 0;
                                            }
                                          }
                                          if (priceHigh != null &&
                                              priceLow != null) {
                                            if (priceHigh > 0 &&
                                                priceLow > 0 &&
                                                (priceHigh < priceLow)) {
                                              setState(() {
                                                var temp =
                                                    _priceHighController.text;
                                                _priceHighController.text =
                                                    _priceLowController.text;
                                                _priceLowController.text = temp;
                                              });
                                              var temp = priceHigh;
                                              priceHigh = priceLow;
                                              priceLow = temp;
                                            }
                                          }

                                          var filterCategories = "";

                                          if (_selectedCategories.isNotEmpty) {
                                            for (var element
                                                in _selectedCategories) {
                                              filterCategories += "${element} ";
                                            }
                                          }
                                          print(filterCategories);

                                          var response = await _productProvider
                                              .getAll(filter: {
                                            'fullTextSearch':
                                                _searchController.text,
                                            'fullTextCategorySearch':
                                                filterCategories,
                                            'priceLow': priceLow,
                                            'priceHigh': priceHigh,
                                          });
                                          setState(() {
                                            //filterSectionVisibility = false;
                                            listProducts = List<Product>.from(
                                                response.data);
                                          });
                                        },
                                        child: const Text("Apply filters"),
                                      ),
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: EdgeInsets.zero,
                                            elevation: 0,
                                            backgroundColor: Color.fromARGB(
                                                0, 255, 255, 255),
                                          ),
                                          child: IconBtn(
                                            svgSrc: upToClose,
                                            press: () {
                                              setState(() {
                                                filterSectionVisibility =
                                                    !filterSectionVisibility;
                                              });
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: listProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 16,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              align: Alignment.topRight,
                              product: listProducts[index],
                              onPress: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 150),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ProductDetailsScreen(
                                      selectedProduct: listProducts[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container()
        : !isLoading
            ? EmptyNotificationsScreen()
            : Container();
  }
}

class PriceLow extends StatelessWidget {
  TextEditingController priceLowController;

  PriceLow({Key? key, required this.priceLowController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        controller: priceLowController,
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
          hintText: "Price Low",
          prefixIcon: const Icon(
            Icons.monetization_on_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class PriceHigh extends StatelessWidget {
  TextEditingController priceHighController;

  PriceHigh({Key? key, required this.priceHighController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        controller: priceHighController,
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
          hintText: "Price High",
          prefixIcon: const Icon(
            Icons.monetization_on_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class CategoriesFilter extends StatefulWidget {
  Set<String> selectedCategories = {};
  CategoriesFilter({super.key, required this.selectedCategories});

  @override
  _CategoriesFilterState createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = categoriesFromUtils;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                categories.length,
                (index) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: FilterCategoryCard(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    isSelected: widget.selectedCategories.contains(
                        categoryNameSelect(
                            categories, index)), // Check if selected
                    press: () {
                      setState(() {
                        if (widget.selectedCategories
                            .contains(categoryNameSelect(categories, index))) {
                          widget.selectedCategories.remove(categoryNameSelect(
                              categories, index)); // Deselect
                        } else {
                          widget.selectedCategories.add(
                              categoryNameSelect(categories, index)); // Select
                        }
                      });
                      print(categoryNameSelect(categories, index));
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FilterCategoryCard extends StatelessWidget {
  const FilterCategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: isSelected
                  ? Color.fromARGB(255, 255, 68, 0)
                      .withOpacity(0.2) // Color when selected
                  : const Color(0xFF979797).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.string(icon),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFFFF7643)
                  : Colors.grey, // Text color when selected
            ),
          )
        ],
      ),
    );
  }
}

class IconBtn extends StatelessWidget {
  IconBtn({
    Key? key,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF979797).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.string(svgSrc),
          ),
        ],
      ),
    );
  }
}
