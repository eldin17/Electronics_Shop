import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/providers/customer_provider.dart';
import 'package:flutter17_mobile/screens/home_screen.dart';
import 'package:flutter17_mobile/screens/login_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RegisterCustomerScreen extends StatefulWidget {
  int UserAccountId;
  RegisterCustomerScreen({super.key, required this.UserAccountId});

  @override
  State<RegisterCustomerScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  final _formKeyRegisterCustomer = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValueRegisterCustomer = {};
  late CustomerProvider _customerProvider;
  TextEditingController dateController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _customerProvider = context.read<CustomerProvider>();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValueRegisterCustomer = {
      'userAccountId': widget.UserAccountId,
      'adresses': [
        {
          'street': "",
          'city': "",
          'country': "",
          'postalCode': "",
          'personId': 0,
        }
      ],
      'paymentMethods': [
        {
          'type': "Cash",
          'provider': "-",
          'key': "-",
          'expiryDate': "",
          'isDefault': true,
          'customerId': 0,
        }
      ],
      'personId': 0,
      'person': {
        'firstName': "",
        'lastName': "",
        'dateOfBirth': null,
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: const Text("Finish Setup")),
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
        const SizedBox(height: 20),
        _headline(context),
        const SizedBox(height: 8),
        _description(context),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        _SignInForm(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        const HasAccountText(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

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
                  const SizedBox(height: 20),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

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
      "Let’s finalize your profile! Fill in the last few details, and you’ll be all set to explore everything we have to offer.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
      ),
    );
  }

  Text _headline(BuildContext context) {
    return Text(
      "Almost There!",
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  FormBuilder _SignInForm() {
    return FormBuilder(
      key: _formKeyRegisterCustomer,
      initialValue: _initialValueRegisterCustomer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderTextField(
              name: 'person.firstName',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Firstname is required';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "Enter your firstname",
                  labelText: "Firstname",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(209, 117, 117, 117)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: SvgPicture.string(
                    firstNameIcon,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderTextField(
              name: 'person.lastName',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lastname is required';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "Enter your lastname",
                  labelText: "Lastname",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(209, 117, 117, 117)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: SvgPicture.string(
                    lastNameIcon,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderDateTimePicker(
              name: 'person.dateOfBirth',
              controller: dateController,
              inputType: InputType.date,
              format: DateFormat('yyyy-MM-dd'),
              initialDate: DateTime.now(),
              validator: (value) {
                if (value == null) {
                  return 'Date of birth is required';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "Select date of birth",
                  labelText: "Date of birth",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(209, 117, 117, 117)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: SvgPicture.string(
                    dateOfBirthIcon,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderField(
              name: 'adresses[0].country',
              validator: (value) {
                if (value == null) {
                  return 'Contry is required';
                }
                return null;
              },
              builder: (FormFieldState<String> field) {
                return TextFormField(
                  controller: TextEditingController(text: field.value),
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Enter your contry",
                      labelText: "Contry",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(209, 117, 117, 117)),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      suffix: SvgPicture.string(
                        countryIcon,
                      ),
                      border: authOutlineInputBorder,
                      enabledBorder: authOutlineInputBorder,
                      focusedBorder: authOutlineInputBorder.copyWith(
                          borderSide:
                              const BorderSide(color: Color(0xFFFF7643)))),
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode:
                          false, // Set to true if you want country codes
                      onSelect: (Country country) {
                        field.didChange(country.name);
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderTextField(
              name: 'adresses[0].city',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'City is required';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "Enter your city",
                  labelText: "City",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(209, 117, 117, 117)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: SvgPicture.string(
                    cityIcon,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderTextField(
              name: 'adresses[0].street',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Street is required';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "Enter your street",
                  labelText: "Street",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(209, 117, 117, 117)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: SvgPicture.string(
                    locationPinIcon,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: FormBuilderTextField(
              name: 'adresses[0].postalCode',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Postal Code is required';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "Enter your postal code",
                  labelText: "Postal Code",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(209, 117, 117, 117)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  suffix: SvgPicture.string(
                    postalCodeIcon,
                  ),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide: const BorderSide(color: Color(0xFFFF7643)))),
            ),
          ),
          
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () async {
              var check =
                  _formKeyRegisterCustomer.currentState?.saveAndValidate();

              Map<String, dynamic> formData = Map<String, dynamic>.from(
                  _formKeyRegisterCustomer.currentState!.value);

              Map<String, dynamic> requestData =
                  Map<String, dynamic>.from(_initialValueRegisterCustomer);

              adressRequestFormat(requestData, formData);
              paymentRequestFormat(requestData);
              personRequestFormat(requestData, formData);

              print("${jsonEncode(requestData)}");
              if (check == true) {
                try {
                  await _customerProvider
                      .registerCustomer(jsonEncode(requestData));

                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomeScreen(),
                    ),
                  );
                } on Exception catch (e) {
                  // TODO
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Ok"),
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
            child: const Text("Confirm"),
          )
        ],
      ),
    );
  }

  void personRequestFormat(
      Map<String, dynamic> requestData, Map<String, dynamic> formData) {
    requestData['person']['dateOfBirth'] =
        DateTime.parse(dateController.text).toUtc().toIso8601String();
    requestData['person']['firstName'] = formData['person.firstName'];
    requestData['person']['lastName'] = formData['person.lastName'];
  }

  void paymentRequestFormat(Map<String, dynamic> requestData) {
    requestData['paymentMethods'][0]['expiryDate'] =
        DateTime.now().add(Duration(days: 10000)).toUtc().toIso8601String();
  }

  void adressRequestFormat(
      Map<String, dynamic> requestData, Map<String, dynamic> formData) {
    requestData['adresses'][0]['street'] = formData['adresses[0].street'];
    requestData['adresses'][0]['city'] = formData['adresses[0].city'];
    requestData['adresses'][0]['country'] = formData['adresses[0].country'];
    requestData['adresses'][0]['postalCode'] =
        formData['adresses[0].postalCode'];
    requestData['adresses'][0]['personId'] =
        _initialValueRegisterCustomer['adresses'][0]['personId'];
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class HasAccountText extends StatelessWidget {
  const HasAccountText({
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
