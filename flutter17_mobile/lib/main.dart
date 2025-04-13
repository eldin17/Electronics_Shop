import 'package:flutter/material.dart';
import 'package:flutter17_mobile/providers/customer_provider.dart';
import 'package:flutter17_mobile/providers/discount_provider.dart';
import 'package:flutter17_mobile/providers/image_upload_provider.dart';
import 'package:flutter17_mobile/providers/login_provider.dart';
import 'package:flutter17_mobile/providers/news_provider.dart';
import 'package:flutter17_mobile/providers/notification_provider.dart';
import 'package:flutter17_mobile/providers/product_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_item_provider.dart';
import 'package:flutter17_mobile/providers/shopping_cart_provider.dart';
import 'package:flutter17_mobile/providers/wishlist_item_provider.dart';
import 'package:flutter17_mobile/providers/wishlist_provider.dart';
import 'package:flutter17_mobile/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => WishlistItemProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => DiscountProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingCartProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingCartItemProvider()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
