import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/register_model.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/providers/image_upload_provider.dart';
import 'package:flutter17_mobile/screens/login_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  final _formKeyRegister = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValueRegister = {};
  late LoginProvider _loginProvider;
  late ImageUploadProvider _imageProvider;
  final TextEditingController _passwordController = TextEditingController();
  String profileImage = '';
  File? _imageFile;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loginProvider = context.read<LoginProvider>();
    _imageProvider = context.read<ImageUploadProvider>();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initialValueRegister = {
      'username': "",
      'email': "",
      'password': "",
      'roleId': null,
      'imageId': 0,
    };
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        profileImage = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: const Text("Sign Up")),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(height: 18),
          _headline(context),
          _description(context),
          const SizedBox(height: 18),
          ProfilePic(
            imageTest: _imageFile != null ? _imageFile!.path : '',
            image: profileImage,
            imageUploadBtnPress: () {
              _selectImage();
              print("BTN - Image Upload");
            },
          ),
          _formBuilder(context),
        ]),
      ),
    );
  }

  FormBuilder _formBuilder(BuildContext context) {
    return FormBuilder(
      key: _formKeyRegister,
      initialValue: _initialValueRegister,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: mailInput(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: usernameInput(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: passwordInput(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: passwordConfirm(),
          ),
          const Divider(),
          const SizedBox(height: 12),
          _button(context),
          const SizedBox(height: 18),
          HaveAccountText(),
        ],
      ),
    );
  }

  ElevatedButton _button(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _formKeyRegister.currentState?.saveAndValidate();
        print(_formKeyRegister.currentState?.value);
        if (_formKeyRegister.currentState!.isValid) {
          try {
            var formData =
                Map<String, dynamic>.from(_formKeyRegister.currentState!.value);

            formData['roleId'] = 1;
            var responseObj;

            if (_imageFile == null) {
              formData['imageId'] = 1;
              print("formData -> $formData");
              responseObj = await _loginProvider
                  .register(RegisterModel.fromJson(formData));

              if (responseObj != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1000),
                    content:
                        Text('🎉 Account created! Let the adventure begin 🌟'),
                  ),
                );
              }
            } else {
              responseObj = await _loginProvider
                  .register(RegisterModel.fromJson(formData));

              await _imageProvider.addSingleImage(responseObj.id!, _imageFile!);

              if (responseObj != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1500),
                    content:
                        Text('🎉 Account created! Let the adventure begin 🌟'),
                  ),
                );
              }
            }
            Future.delayed(Duration(milliseconds: 1500), () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  transitionDuration: Duration.zero,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      LoginScreen(),
                ),
              );
            });
          } on Exception catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 1500),
                content:
                    Text('❌ Oops! Something went wrong. Please try again.'),
              ),
            );
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) => AlertDialog(
            //     title: Text("Error"),
            //     content: Text(e.toString()),
            //     actions: [
            //       TextButton(
            //         onPressed: () => Navigator.pop(context),
            //         child: Text("Ok"),
            //       )
            //     ],
            //   ),
            // );
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
      child: const Text("Create"),
    );
  }

  FormBuilderTextField passwordConfirm() {
    return FormBuilderTextField(
      name: 'confirmPw',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm your password';
        } else if (value != _passwordController.text) {
          return "Passwords dont match";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      obscureText: true,
      decoration: InputDecoration(
          //hintText: "Confirm your password",
          labelText: "Confirm Password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(color: Color.fromARGB(209, 117, 117, 117)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.string(lockIcon),
            ],
          ),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Color(0xFFFF7643)))),
    );
  }

  FormBuilderTextField passwordInput() {
    return FormBuilderTextField(
      controller: _passwordController,
      name: 'password',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      obscureText: _obscureText,
      decoration: InputDecoration(
          //hintText: "Enter your password",
          labelText: "Password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(color: Color.fromARGB(209, 117, 117, 117)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: _obscureText
                      ? SvgPicture.string(visibilityIcon)
                      : SvgPicture.string(visibilityLockIcon)),
              const SizedBox(width: 8),
              SvgPicture.string(lockIcon),
            ],
          ),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Color(0xFFFF7643)))),
    );
  }

  FormBuilderTextField usernameInput() {
    return FormBuilderTextField(
      name: 'username',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username is required';
        } else if (value.length < 3)
          return 'Too short, use more than 2 letters';
        else if (value.length > 20) return 'Too long, use less than 20 letters';
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //hintText: "Enter your username",
          labelText: "Username",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(color: Color.fromARGB(209, 117, 117, 117)),
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
    );
  }

  FormBuilderTextField mailInput() {
    return FormBuilderTextField(
      name: 'email',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        } else if (!EmailValidator.validate(value.toString())) {
          return 'Enter a valid email address';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //hintText: "something@mail.com",
          labelText: "Email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(color: Color.fromARGB(209, 117, 117, 117)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          suffix: SvgPicture.string(
            mailIcon,
          ),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder.copyWith(
              borderSide: const BorderSide(color: Color(0xFFFF7643)))),
    );
  }
}

class ProfilePic extends StatelessWidget {
  ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
    required this.imageTest,
  });

  final String image;
  String imageTest;
  final bool isShowPhotoUpload;
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
          image != ''
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(File(imageTest)),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/Logo2.jpg'),
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

class HaveAccountText extends StatelessWidget {
  const HaveAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Color(0xFF757575)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    LoginScreen(),
              ),
            );
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Color(0xFFFF7643),
            ),
          ),
        ),
      ],
    );
  }
}

Text _description(BuildContext context) {
  return Text(
    "Enter your email, username, password \nand profile image for sign up",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
    ),
  );
}

Text _headline(BuildContext context) {
  return Text(
    "Create Account",
    style: Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(fontWeight: FontWeight.bold),
  );
}
