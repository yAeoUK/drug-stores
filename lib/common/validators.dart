import 'package:drug_stores/configs/language_config.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class Validators {
  String field;
  int? minimumCharacters;
  int? maximumValue;
  String? otherFieldName;
  TextFieldBloc? otherFieldBloc;

  Validators(
      {required this.field,
      this.minimumCharacters,
      this.otherFieldName,
      this.maximumValue,
      this.otherFieldBloc});

  String? required(dynamic value) {
    if (value == null || value == '')
      return 'form.fieldRequired'.tr(namedArgs: {'field': field});
    return null;
  }

  String? minNCharacters(dynamic value) {
    if (value.length < minimumCharacters)
      return 'form.minNCharacters'.tr(
          namedArgs: {'field': field, 'min': minimumCharacters!.toString()});
    return null;
  }

  String? maxValue(dynamic value) {
    if (int.parse(value) > maximumValue!)
      return 'form.maxValue'
          .tr(namedArgs: {'field': field, 'max': maximumValue!.toString()});
    return null;
  }

  String? identical(dynamic value) {
    if (value.toString() != otherFieldBloc!.value.toString())
      return 'form.notIdenticalValues'
          .tr(namedArgs: {'label1': field, 'label2': otherFieldName!});
    return null;
  }

  String? positiveNumber(dynamic value) {
    if (!RegExp("^[0-9]{1,}\$").hasMatch(value.toString()))
      return LanguageConfig.mustBePositiveNumber
          .tr(namedArgs: {'field': field});
    if (int.parse(value.toString()) < 0)
      return LanguageConfig.mustBePositiveNumber
          .tr(namedArgs: {'field': field});
    return null;
  }
}
