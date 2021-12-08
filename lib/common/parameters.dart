import 'dart:ui';
import 'package:flutter/material.dart';

import 'size_config.dart';


const SUPPORTED_LOCALES = [
  Locale('en', ''),
  Locale('ar', ''),
];

const DATABASE_VERSION = 1;
const ROOT_URL = 'http://onlinemarket.atwebpages.com/';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);


List<Map<String, String>> getCategories(BuildContext context) =>
    [
      {'icon': 'assets/icons/Flash Icon.svg', 'text': 'Flash Deal'},
      {'icon': 'assets/icons/Bill Icon.svg', 'text': 'Bill'},
      {'icon': 'assets/icons/Game Icon.svg', 'text': 'Game'},
      {'icon': 'assets/icons/Gift Icon.svg', 'text': 'Daily Gift'},
      {'icon': 'assets/icons/Discover.svg', 'text': 'More'},
    ];

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

const defaultDuration = Duration(milliseconds: 250);