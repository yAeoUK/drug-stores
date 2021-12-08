// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class Validators {
  String field;
  int? minimumCharacters;
  String? otherFieldName;
  TextFieldBloc? otherFieldBloc;

  Validators(
      {required this.field,
      this.minimumCharacters,
      this.otherFieldName,
      this.otherFieldBloc});

  String? required(dynamic value) {
    if (value == null || value == '')
      return 'form.fieldRequired'.tr(namedArgs: {'field': field});
  }

  String? minNCharacters(dynamic value) {
    if (value.length < minimumCharacters)
      return 'form.minNCharacters'.tr(
          namedArgs: {'field': field, 'min': minimumCharacters!.toString()});
  }

  String? identical(dynamic value) {
    if (value.toString() != otherFieldBloc!.value.toString())
      return 'form.notIdenticalValues'
          .tr(namedArgs: {'label1': field, 'label2': otherFieldName!});
  }
}
