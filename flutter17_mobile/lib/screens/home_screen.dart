import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/product.dart';
import 'package:flutter17_mobile/providers/product_provider.dart';
import 'package:flutter17_mobile/screens/product_details_screen.dart';
import 'package:flutter17_mobile/screens/products_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productsList = [];
  List<Product> latestProductsList = [];
  List<Product> discountProductsList = [];
  late ProductProvider _productProvider;
  bool isLoading = true;
  TextEditingController searchController = new TextEditingController();

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
    //var productsObj = await _productProvider.getAll();
    var productsObj = await _productProvider
        .getAllWithChecks(LoginResponse.currentCustomer!.id!);

    setState(() {
      productsList = List<Product>.from(productsObj.data);

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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container()
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    HomeHeader(
                      searchController: searchController,
                    ),
                    DiscountBanner(),
                    LatestProducts(
                      products: latestProductsList,
                    ),
                    Categories(),
                    News(),
                    SizedBox(height: 20),
                    DiscountProducts(
                      products: discountProductsList,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}

class HomeHeader extends StatefulWidget {
  TextEditingController searchController;

  HomeHeader({super.key, required this.searchController});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int num = 13;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SearchField(searchController: widget.searchController)),
          const SizedBox(width: 16),
          // IconBtnWithCounter(
          //   // numOfitem: 3,
          //   svgSrc: cartIcon,
          //   press: () {},
          // ),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            svgSrc: bellIcon,
            numOfitem: num,
            press: () {
              setState(() {
                num = 0;
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
                    ProductsScreen(
                      searchBox: value,
                    )),
          );
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

class IconBtnWithCounter extends StatelessWidget {
  IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  int numOfitem;
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
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "A Summer Surpise\n"),
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = categoriesFromUtils;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: SectionTitle(
            showSeeMore: false,
            title: "Browse Category",
            press: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                categories.length,
                (index) => Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: CategoryCard(
                    icon: categories[index]["icon"],
                    text: categories[index]["text"],
                    press: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 150),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductsScreen(
                                      category: categories[index]["text"],
                                    )),
                      );
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

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.string(icon),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class News extends StatelessWidget {
  const News({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            showSeeMore: true,
            title: "News",
            press: () {
              print("News See More");
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "https://i.postimg.cc/yY2bNrmd/Image-Banner-2.png",
                category: "Phones",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: "https://i.postimg.cc/BQjz4G1k/Image-Banner-3.png",
                category: "Laptops",
                numOfBrands: 24,
                press: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    required this.showSeeMore,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  bool showSeeMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        showSeeMore
            ? TextButton(
                onPressed: press,
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                child: const Text("See more"),
              )
            : Container(),
      ],
    );
  }
}

class LatestProducts extends StatefulWidget {
  List<Product> products;
  LatestProducts({super.key, required this.products});

  @override
  State<LatestProducts> createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            showSeeMore: true,
            title: "Latest Products",
            press: () {
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
                        ProductsScreen(
                          fromLatest: true,
                        )),
              );
              print("Latest See More");
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                widget.products.length < 4 ? widget.products.length : 4,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ProductCard(
                      align: Alignment.bottomRight,
                        product: widget.products[index],
                        onPress: () {
                          print(widget.products[index].brand);
                          print(
                              "favourite: ${widget.products[index].isFavourite}");
                          print(
                              "review: ${widget.products[index].reviewScoreAvg}");
                          Navigator.of(context)
                              .push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 150),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ProductDetailsScreen(
                                selectedProduct: widget.products[index],
                              ),
                            ),
                          )
                              .then((_) {
                            setState(() {});
                          });
                        }),
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}

class DiscountProducts extends StatelessWidget {
  List<Product> products;

  DiscountProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            showSeeMore: true,
            title: "On Discount",
            press: () {
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
                        ProductsScreen(
                          fromOnDiscount: true,
                        )),
              );
              print("Discount See More");
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                products.length < 4 ? products.length : 4,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ProductCard(
                      align: Alignment.bottomRight,
                      product: products[index],
                      onPress: () {
                        print(products[index].brand);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
    required this.align,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;
  final AlignmentGeometry align;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: aspectRetio,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 53, 53, 53).withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 4), // Soft drop shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        adjustImage(product.productImages![0].image!.path!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${product.brand!} ${product.model!}",
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    product.finalPrice == product.price
                        ? Text(
                            "${product.finalPrice}€",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 118, 67),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${product.price}€",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Color.fromARGB(
                                              141, 158, 158, 158),
                                          decorationThickness: 3)),
                                  Text(
                                    "${product.finalPrice}€",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 255, 118, 67),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: align,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: product.isFavourite!
                          ? const Color(0xFFFF7643).withOpacity(0.15)
                          : const Color(0xFF979797).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.string(
                      heartIconFull,
                      colorFilter: ColorFilter.mode(
                          product.isFavourite!
                              ? const Color(0xFFFF4848)
                              : const Color(0xFFDBDEE4),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
