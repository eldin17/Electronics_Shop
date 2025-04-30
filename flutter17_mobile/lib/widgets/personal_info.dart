import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/helpers/login_response.dart';
import 'package:flutter17_mobile/models/user_account.dart';
import 'package:flutter17_mobile/providers/customer_provider.dart';
import 'package:flutter17_mobile/screens/home_screen.dart';
import 'package:flutter17_mobile/screens/login_screen.dart';
import 'package:flutter17_mobile/screens/master_screen.dart';
import 'package:flutter17_mobile/screens/welcome.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PersonalInfoScreen extends StatefulWidget {
  UserAccount userAcc;
  PersonalInfoScreen({super.key, required this.userAcc});

  @override
  State<PersonalInfoScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<PersonalInfoScreen> {
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
      'personId': LoginResponse.currentCustomer!.person!.id,
      'person': {
        'firstName': "",
        'lastName': "",
        'dateOfBirth': null,
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: smallScreen(context),
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      ],
    );
  }

  Text _description(BuildContext context) {
    return Text(
      "Need to make a change? Update your personal details below and keep your profile up to date.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
      ),
    );
  }

  Text _headline(BuildContext context) {
    return Text(
      "Update Your Info",
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
              initialValue: LoginResponse.currentCustomer?.person?.firstName,
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
              initialValue: LoginResponse.currentCustomer?.person?.lastName,
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
              initialValue: LoginResponse.currentCustomer?.person?.dateOfBirth,
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
              initialValue: LoginResponse.currentCustomer?.adresses?[0].country,
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
              initialValue: LoginResponse.currentCustomer?.adresses?[0].city,
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
              initialValue: LoginResponse.currentCustomer?.adresses?[0].street,
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
              initialValue:
                  LoginResponse.currentCustomer?.adresses?[0].postalCode,
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
                  var obj = await _customerProvider.update(
                      LoginResponse.currentCustomer!.id!, requestData);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 1500),
                      content: Text(
                          '✅ Nicely done, ${obj.person?.firstName}! Everything’s up to date.'),
                    ),
                  );

                  setState(() {
                    LoginResponse.currentCustomer = obj;
                  });

                  Navigator.pop(context);
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 1500),
                      content: Text(
                          '😕 Hmm, couldn’t save your info. Mind trying again?'),
                    ),
                  ); // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => AlertDialog(
                  //           title: Text("Error"),
                  //           content: Text(e.toString()),
                  //           actions: [
                  //             TextButton(
                  //               onPressed: () => Navigator.pop(context),
                  //               child: Text("Ok"),
                  //             )
                  //           ],
                  //         ));
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
          )
        ],
      ),
    );
  }

  void personRequestFormat(
      Map<String, dynamic> requestData, Map<String, dynamic> formData) {
    var localDate = DateTime.parse(dateController.text);
    var safeUtcDate =
        DateTime.utc(localDate.year, localDate.month, localDate.day);
    requestData['person']['dateOfBirth'] = safeUtcDate.toIso8601String();
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


