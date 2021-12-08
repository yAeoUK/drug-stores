import 'package:drug_stores/common/validators.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class PasswordController extends TextFieldBloc {
  PasswordController()
      : super(
          validators: [
            Validators(field: 'password'.tr()).required,
            Validators(field: 'password'.tr(), minimumCharacters: 6)
                .minNCharacters
          ],
        );
}
