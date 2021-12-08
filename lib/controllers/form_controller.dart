import 'package:drug_stores/configs/language_config.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:drug_stores/models/success_response.dart';

// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get/get_rx/get_rx.dart';

class FormController extends FormBloc<SuccessResponse, FailureResponse> {
  RxString message = ''.obs;
  RxBool loading = false.obs;

  @override
  void onSubmitting() => throw UnimplementedError();

  void onMessageReceived(String content) {
    emitFailure();
    message(content);
  }

  void onPreConnect() {
    loading(true);
    message('');
  }

  void onPostConnect() => loading(false);

  void onConnectionFailed() {
    emitFailure();
    message(LanguageConfig.formNoConnection.tr());
  }

  void onConnectionSucceed() => emitSuccess();
}
