import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/screens/home_screen.dart';
import 'package:flutter17_mobile/screens/master_screen.dart';
import 'package:flutter17_mobile/screens/register_customer_screen.dart';
import 'package:flutter17_mobile/screens/register_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../helpers/login_response.dart';
import '../helpers/test.dart';
import '../models/login_model.dart';
import '../providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValueLogin = {};
  late LoginProvider _loginProvider;
  bool _rememberMe = false;
  bool _obscureText = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loginProvider = context.read<LoginProvider>();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initialValueLogin = {
      'username': "",
      'password': "",
    };
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: const Text("Sign In")),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: isSmallScreen
                ? const EdgeInsets.symmetric(horizontal: 16)
                : const EdgeInsets.all(50),
            child: SingleChildScrollView(
              child:
                  isSmallScreen ? smallScreen(context) : largeScreen(context),
            ),
          ),
        ),
      ),
    );
  }

  Column smallScreen(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 120),
        _headline(context),
        const SizedBox(height: 8),
        _description(context),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        _SignInForm(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        const NoAccountText(),
      ],
    );
  }

  Column largeScreen(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  _headline(context),
                  const SizedBox(height: 8),
                  _description(context),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Text(
                    "Sign In",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  _SignInForm(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const NoAccountText(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text _description(BuildContext context) {
    return Text(
      "Sign in with your username and password  \nor sign up if you are new",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
      ),
    );
  }

  Text _headline(BuildContext context) {
    return Text(
      "Welcome Back",
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  FormBuilder _SignInForm() {
    return FormBuilder(
      key: _formKeyLogin,
      initialValue: _initialValueLogin,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'username',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: "Enter your username",
                labelText: "Username",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(209, 117, 117, 117)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                suffix: SvgPicture.string(
                  accountIcon,
                ),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: Color(0xFFFF7643)))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderTextField(
              name: 'password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
              obscureText: _obscureText,
              decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(209, 117, 117, 117)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         _obscureText = !_obscureText;
                      //       });
                      //     },
                      //     child: _obscureText
                      //         ? SvgPicture.string(visibilityIcon)
                      //         : SvgPicture.string(visibilityLockIcon)),
                      // const SizedBox(width: 8),
                      SvgPicture.string(lockIcon),
                    ],
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  shape: CircleBorder(),
                  activeColor: Color(0xFFFF7643),
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = !_rememberMe;
                    });
                    print(_rememberMe);
                  }),
              const Text(
                "Remember me",
                style: TextStyle(color: Color(0xFF757575)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () async {
              var check = _formKeyLogin.currentState?.saveAndValidate();
              print(_formKeyLogin.currentState?.value);

              if (check == true) {
                try {
                  var formData = Map<String, dynamic>.from(
                      _formKeyLogin.currentState!.value);

                  await _loginProvider.login(LoginModel.fromJson(formData));
                  if (_rememberMe) {
                    var box = Hive.box('authBox');
                    await box.put('token', LoginResponse.token);
                    await box.put('userId', LoginResponse.userId);
                    await box.put('roleName', LoginResponse.roleName);
                    await box.put('isCustomer', LoginResponse.isCustomer);
                    await box.put('isSeller', LoginResponse.isSeller);
                  }

                  print(LoginResponse.token);
                  print(LoginResponse.userId);
                  print(LoginResponse.roleName);
                  print("customer - ${LoginResponse.isCustomer}");
                  print("seller - ${LoginResponse.isSeller}");

                  LoginResponse.isCustomer!
                      ? Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration.zero,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    MasterScreen(
                              index: 0,
                            ),
                          ),
                        )
                      : Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: Duration.zero,
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                RegisterCustomerScreen(
                                  rememberMe: _rememberMe,
                                    UserAccountId: LoginResponse.userId!),
                          ),
                        );
                } on Exception catch (e) {
                  // TODO
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text("Something went wrong!"),
                            content: Text("Wrong username or password"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Try again"),
                              )
                            ],
                          ));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFFF7643),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text("Continue"),
          )
        ],
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(color: Color(0xFF757575)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RegisterScreen(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color(0xFFFF7643),
            ),
          ),
        ),
      ],
    );
  }
}
