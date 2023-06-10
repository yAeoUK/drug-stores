import 'package:flutter/material.dart';

class LanguageConfig {
  static final supportedLocales = [Locale('en'), Locale('ar')];
  static final fallbackLocale = Locale('en');
  static final translationPath = 'assets/translations';

  static final String adminLogin = 'adminLogin';
  static final String salesmanLogin = 'salesmanLogin';
  static final String salesmanRegister = 'salesmanRegister';

  static final String username = 'username';
  static const String password = 'password';
  static final String confirmPassword = 'confirmPassword';

  static final String formNoConnection = 'form.noConnection';
  static final String formOk = 'form.ok';

  static final String itemListEmpty = 'itemList.empty';
  static final String itemListLoadMore = 'itemList.loadMore';

  static final String dialogueYes = 'dialogue.yes';
  static final String dialogueNo = 'dialogue.no';

  static final String drugName = 'drug.name';
  static final String drugQuantity = 'drug.quantity';

  static final String mustBePositiveNumber = 'form.mustBePositiveNumber';

  static final String fullName = 'fullName';

  static final String pharmacyName = 'pharmacy.name';
}
