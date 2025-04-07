import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/customer.dart';
import 'package:flutter17_mobile/providers/product_provider.dart';
import 'package:flutter17_mobile/screens/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  late ProductProvider _prov;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prov = context.read<ProductProvider>();

  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return screenContent(context);
  }

  Scaffold screenContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  var box = Hive.box('authBox');
                  await box.delete('token');
                  await box.delete('userId');
                  await box.delete('roleName');
                  await box.delete('isCustomer');
                  await box.delete('isSeller');

                  LoginResponse.token = null;
                  LoginResponse.userId = null;
                  LoginResponse.roleName = null;
                  LoginResponse.isCustomer = null;
                  LoginResponse.isSeller = null;
                  LoginResponse.currentCustomer = null;

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                    (Route<dynamic> route) =>
                        false, 
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color.fromARGB(255, 67, 127, 255),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                child: const Text("Log Out"),
              )             
            ],
          ),
        ),
      ),
    );
  }
}
