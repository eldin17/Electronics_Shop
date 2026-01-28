import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/providers/image_upload_provider.dart';
import 'package:flutter17_mobile/providers/user_account_provider.dart';
import 'package:flutter17_mobile/screens/master_screen.dart';
import 'package:flutter17_mobile/screens/my_orders_screen.dart';
import 'package:flutter17_mobile/screens/no_payment_methods.dart';
import 'package:flutter17_mobile/screens/payment_methods_screen.dart';
import 'package:flutter17_mobile/screens/splash_screen.dart';
import 'package:flutter17_mobile/widgets/account_info.dart';
import 'package:flutter17_mobile/widgets/deactivate.dart';
import 'package:flutter17_mobile/widgets/loading.dart';
import 'package:flutter17_mobile/widgets/personal_info.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserAccountProvider _userAccountProvider;
  late ImageUploadProvider _imageProvider;

  late UserAccount userAcc;
  bool isLoading = true;
  String profileImage = '';
  File? _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userAccountProvider = context.read<UserAccountProvider>();
    _imageProvider = context.read<ImageUploadProvider>();

    initForm();
  }

  Future initForm() async {
    var obj = await _userAccountProvider.getById(LoginResponse.userId!);

    setState(() {
      userAcc = obj;
      profileImage = adjustImage(userAcc.image!.path!);

      isLoading = false;
    });
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        profileImage = pickedFile.path;
      });
      await _imageProvider.addSingleImage(LoginResponse.userId!, _imageFile!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text("Image uploaded. Looking fresh! ✨"),
          backgroundColor: Color.fromARGB(255, 158, 158, 158),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text("Profile"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ProfilePic(
                    imageUpload: _imageFile != null ? _imageFile!.path : '',
                    imageDB: profileImage,
                    imageUploadBtnPress: () async {
                      _selectImage();
                      print("BTN - Image Upload");
                    },
                  ),
                  const SizedBox(height: 20),
                  ProfileMenu(
                    text: "  My Personal Info",
                    icon: accountIcon,
                    press: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (_) => PersonalInfoScreen(userAcc: userAcc),
                        ),
                      );
                      // Navigator.of(context).push(
                      //   PageRouteBuilder(
                      //     transitionDuration: Duration(milliseconds: 150),
                      //     transitionsBuilder:
                      //         (context, animation, secondaryAnimation, child) {
                      //       return FadeTransition(
                      //         opacity: animation,
                      //         child: child,
                      //       );
                      //     },
                      //     pageBuilder:
                      //         (context, animation, secondaryAnimation) =>
                      //             PersonalInfoScreen(
                      //       userAcc: userAcc,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  ProfileMenu(
                    text: "My Orders",
                    icon: paymentIcon,
                    press: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 150),
                          pageBuilder: (_, __, ___) => MyOrders(),
                          transitionsBuilder: (_, animation, __, child) =>
                              FadeTransition(opacity: animation, child: child),
                        ),
                      );
                      // Navigator.of(context).push(
                      //   PageRouteBuilder(
                      //     transitionDuration: Duration(milliseconds: 150),
                      //     transitionsBuilder:
                      //         (context, animation, secondaryAnimation, child) {
                      //       return FadeTransition(
                      //         opacity: animation,
                      //         child: child,
                      //       );
                      //     },
                      //     pageBuilder:
                      //         (context, animation, secondaryAnimation) =>
                      //             MyOrders(),
                      //   ),
                      // );
                    },
                  ),
                  ProfileMenu(
                    text: "  My Account",
                    icon: settingsIcon,
                    press: () => {
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AccountInfoScreen(
                            userAcc: userAcc,
                          ),
                        ),
                      )
                    },
                  ),
                  ProfileMenu(
                    text: "  Deactivate",
                    icon: trashIcon,
                    press: () {
                      showDeactivatePrompt(context, () async {
                        await _userAccountProvider
                            .deactivate(LoginResponse.userId!);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 3000),
                            content: Text(
                                "Your account has been deactivated. We're sad to see you go — come back anytime!"),
                            backgroundColor: Color.fromARGB(255, 158, 158, 158),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                          ),
                        );

                        Future.delayed(Duration(milliseconds: 3000), () async {
                          await logOutMethod(context);
                        });
                      });
                    },
                  ),
                  ProfileMenu(
                    text: "   Log Out",
                    icon: logOutIcon,
                    press: () async {
                      await logOutMethod(context);
                    },
                  ),
                ],
              ),
            ),
          )
        : LoadingScreen();
  }

  Future<void> logOutMethod(BuildContext context) async {
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
      (Route<dynamic> route) => false,
    );
  }
}

class ProfilePic extends StatelessWidget {
  ProfilePic({
    super.key,
    required this.imageDB,
    this.imageUploadBtnPress,
    required this.imageUpload,
  });

  final String imageDB;
  String imageUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          imageUpload != ''
              ? CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(File(imageUpload)),
                )
              : CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(imageDB),
                ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7643),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.string(icon,
                width: 25, height: 25, color: Color(0xFFFF7643)),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF757575),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
            ),
          ],
        ),
      ),
    );
  }
}
