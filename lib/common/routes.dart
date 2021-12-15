import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';
import 'package:drug_stores/screens/admin/home/home.dart';
import 'package:drug_stores/screens/salesman/home/home.dart';
import 'package:drug_stores/screens/welcome/welcome.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
  SalesmanHomeScreen.routeName: (context) => SalesmanHomeScreen(),
  DrugForm.addRouteName: (context) => DrugForm(),
  DrugForm.editRouteName: (context) => DrugForm(),
};
