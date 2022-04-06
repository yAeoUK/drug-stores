import 'package:drug_stores/configs/language_config.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'tabs/admin_login.dart';
import 'tabs/salesman_login.dart';
import 'tabs/salesman_register.dart';

class WelcomeScreen extends GetView {
  static String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: LanguageConfig.adminLogin.tr(),
                ),
                Tab(
                  text: LanguageConfig.salesmanLogin.tr(),
                ),
                Tab(
                  text: 'salesmanRegister'.tr(),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AdminLoginTab(),
              SalesmanLoginTab(),
              SalesmanRegisterTab()
            ],
          ),
        ));
  }
}
