import 'package:flutter/material.dart';
import 'package:flutter17_mobile/screens/master_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/providers/customer_provider.dart';

class SplashScreen extends StatelessWidget {
  late CustomerProvider _customerProvider;

  SplashScreen({super.key}) {
    _customerProvider = new CustomerProvider();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return isSmallScreen ? smallScreen(context) : largeScreen(context);
  }

  Scaffold smallScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 2),
              _logo(),
              const Spacer(flex: 3),
              _headline(context),
              const Spacer(),
              _description(context),
              const Spacer(flex: 3),
              _button(context),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold largeScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              const Spacer(flex: 2),
              _logo(),
              const Spacer(flex: 3),
              Container(
                height: 150,
                child: Column(
                  children: [
                    _headline(context),
                    const Spacer(),
                    _description(context),
                    const Spacer(flex: 3),
                    _button(context),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _button(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        var box = Hive.box('authBox');
        var token = box.get('token');
        var isCustomer = box.get('isCustomer');
        var isSeller = box.get('isSeller');
        var userId = box.get('userId');
        var roleName = box.get('roleName');
        print(token);

        if (token != null && !isTokenExpired(token)) {
          if (isCustomer) {
            var customer = await _customerProvider
                .getAll(filter: {'userAccountId': userId});
            if (customer.data.isNotEmpty){
              LoginResponse.currentCustomer = customer.data[0];
              LoginResponse.token = token;
              LoginResponse.roleName = roleName;
              LoginResponse.isCustomer = isCustomer;
              LoginResponse.isSeller = isSeller;
              LoginResponse.userId = userId;
            }
            print("HepeK!! ${LoginResponse.currentCustomer!.id}");
          } else {print('splash');
            await box.delete('token');
            await box.delete('userId');
            await box.delete('roleName');
            await box.delete('isCustomer');
            await box.delete('isSeller');
          }

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration.zero,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MasterScreen(index: 0),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration.zero,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginScreen(),
            ),
          );
        }
      },
      icon: const Text("Skip"),
      label: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
    );
  }

  Text _description(BuildContext context) {
    return Text(
      "Laptops, phones, and accessories. \nEverything you need, in one place.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
      ),
    );
  }

  Text _headline(BuildContext context) {
    return Text(
      "Technology. Made for You.",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  Container _logo() {
    return Container(
      width: 300,
      child: Center(
        child: Image(
          image: AssetImage('assets/images/Logo.jpg'),
        ),
      ),
    );
  }
}
