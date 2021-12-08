import 'package:drug_stores/common/validators.dart';
// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class UsernameController extends TextFieldBloc {
  UsernameController()
      : super(
          validators: [Validators(field: 'username'.tr()).required],
        );
}
