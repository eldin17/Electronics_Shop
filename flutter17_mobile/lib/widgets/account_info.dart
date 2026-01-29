import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/helpers/utils.dart';
import 'package:flutter17_mobile/models/register_model.dart';
import 'package:flutter17_mobile/models/reset_pw.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/providers/image_upload_provider.dart';
import 'package:flutter17_mobile/providers/user_account_provider.dart';
import 'package:flutter17_mobile/screens/login_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class AccountInfoScreen extends StatefulWidget {
  UserAccount userAcc;
  AccountInfoScreen({super.key, required this.userAcc});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool _obscureTextOld = true;
  bool _obscureTextNew = true;
  final _formKeyEditInfo = GlobalKey<FormBuilderState>();
  final _formKeyResetPassword = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValueEditInfo = {};
  Map<String, dynamic> _initialValueResetPassword = {};
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  late UserAccountProvider _userAccountProvider;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _userAccountProvider = context.read<UserAccountProvider>();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initialValueEditInfo = {
      'username': "",
      'email': "",
    };

    _initialValueResetPassword = {
      'userAccId': LoginResponse.userId,
      'oldPassword': "",
      'newPassword': "",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          const SizedBox(height: 18),
          _headline(context),
          _description(context),
          const SizedBox(height: 48),
          //_formBuilder1(context),
          _formBuilder2(context),
        ]),
      ),
    );
  }

  FormBuilder _formBuilder1(BuildContext context) {
    return FormBuilder(
      key: _formKeyEditInfo,
      initialValue: _initialValueEditInfo,
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
          const SizedBox(height: 12),
          _button1(context),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  FormBuilder _formBuilder2(BuildContext context) {
    return FormBuilder(
      key: _formKeyResetPassword,
      initialValue: _initialValueResetPassword,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: oldPasswordInput(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: newPasswordInput(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: passwordConfirm(),
          ),
          const Divider(),
          const SizedBox(height: 12),
          _button2(context),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  ElevatedButton _button1(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _formKeyEditInfo.currentState?.saveAndValidate();
        print(_formKeyEditInfo.currentState?.value);
        if (_formKeyEditInfo.currentState!.isValid) {
          try {
            var formData =
                Map<String, dynamic>.from(_formKeyEditInfo.currentState!.value);

            print("formData -> $formData");
            var responseObj = await _userAccountProvider.update(
                LoginResponse.userId!, UserAccount.fromJson(formData));
            print("responseObj -> $responseObj");

            if (responseObj != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text(
                      "✅ Changes saved! You're all set to keep exploring 🚀"),
                ),
              );
            }
          } on Exception catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 1500),
                content:
                    Text('❌ Oops! Something went wrong. Please try again.'),
              ),
            );
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
      child: const Text("Update Info"),
    );
  }

  ElevatedButton _button2(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _formKeyResetPassword.currentState?.saveAndValidate();
        print(_formKeyResetPassword.currentState?.value);
        if (_formKeyResetPassword.currentState!.isValid) {
          try {
            var formData = Map<String, dynamic>.from(
                _formKeyResetPassword.currentState!.value);

            formData['userAccId'] = _initialValueResetPassword['userAccId'];

            print("formData -> $formData");
            var responseObj =
                await _userAccountProvider.resetPW(ResetPW.fromJson(formData));

            if (responseObj != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text('✅ Password changed! Stay safe out there 🔐'),
                ),
              );
            }
          } on Exception catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 1500),
                content:
                    Text('❌ Oops! Something went wrong. Please try again.'),
              ),
            );
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
      child: const Text("Reset Password"),
    );
  }

  FormBuilderTextField passwordConfirm() {
    return FormBuilderTextField(
      name: 'confirmPw',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm new password';
        } else if (value != _newPasswordController.text) {
          return " New passwords don't match";
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      obscureText: true,
      decoration: InputDecoration(
          //hintText: "Confirm your password",
          labelText: "Confirm New Password",
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

  FormBuilderTextField oldPasswordInput() {
    return FormBuilderTextField(
      controller: _oldPasswordController,
      name: 'oldPassword',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      obscureText: _obscureTextOld,
      decoration: InputDecoration(
          //hintText: "Enter your password",
          labelText: "Current Password",
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
                      _obscureTextOld = !_obscureTextOld;
                    });
                  },
                  child: _obscureTextOld
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

  FormBuilderTextField newPasswordInput() {
    return FormBuilderTextField(
      controller: _newPasswordController,
      name: 'newPassword',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      obscureText: _obscureTextNew,
      decoration: InputDecoration(
          //hintText: "Enter your password",
          labelText: "New Password",
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
                      _obscureTextNew = !_obscureTextNew;
                    });
                  },
                  child: _obscureTextNew
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
      initialValue: widget.userAcc.username,
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
      initialValue: widget.userAcc.email,
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

Text _description(BuildContext context) {
  return Text(
    "You can change your password here.\nContact support to update other details..",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
    ),
  );
}

Text _headline(BuildContext context) {
  return Text(
    "Account Security",
    style: Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(fontWeight: FontWeight.bold),
  );
}
