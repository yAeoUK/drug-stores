import 'package:drug_stores/screens/admin/drug_form/drug_form.dart';
import 'package:drug_stores/screens/admin/drug_list/drug_list.dart';
import 'package:drug_stores/screens/admin/home/home.dart';
import 'package:drug_stores/screens/admin/order/order.dart';
import 'package:drug_stores/screens/admin/order_list/order_list.dart';
import 'package:drug_stores/screens/admin/pharmacy_form/pharmacy_form.dart';
import 'package:drug_stores/screens/admin/pharmacy_list/pharmacy_list.dart';
import 'package:drug_stores/screens/salesman/home/home.dart';
import 'package:drug_stores/screens/salesman/order_form/order_form.dart';
import 'package:drug_stores/screens/salesman/order_list/order_list.dart';
import 'package:drug_stores/screens/welcome/welcome.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
  AdminDrugList.routeName: (context) => AdminDrugList(),
  AdminOrderList.routeName: (context) => AdminOrderList(),
  AdminDrugForm.addRouteName: (context) => AdminDrugForm(),
  AdminDrugForm.editRouteName: (context) => AdminDrugForm(),
  AdminOrderScreen.routeName: (context) => AdminOrderScreen(),
  SalesmanHomeScreen.routeName: (context) => SalesmanHomeScreen(),
  SalesmanOrderList.rootName: (context) => SalesmanOrderList(),
  SalesmanOrderForm.rootName: (context) => SalesmanOrderForm(),
  SalesmanOrderForm.editRouteName: (context) => SalesmanOrderForm(),
  AdminPharmacyForm.addRouteName: (context) => AdminPharmacyForm(),
  AdminPharmacyForm.editRouteName: (context) => AdminPharmacyForm(),
  AdminPharmacyList.routeName: (context) => AdminPharmacyList()
};
