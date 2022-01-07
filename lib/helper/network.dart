import 'dart:convert';

import 'package:drug_stores/helper/device_info.dart';
import 'package:drug_stores/models/failure_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Network {
  /// show loading dialogue, hide old results or errors, etc
  Function()? onPreConnect;

  /// Hide loading dialogue, etc
  Function()? onPostConnect;

  /// Show results, show no results
  Function(dynamic body) onConnectionSucceed;

  /// Show no network connection
  Function()? onConnectionFailed;

  /// Show the [message]
  Function(FailureResponse message)? onMessageReceived;

  Network({
    this.onPreConnect,
    this.onPostConnect,
    required this.onConnectionSucceed,
    this.onConnectionFailed,
    this.onMessageReceived,
  });

  static Map<String, String> headers = {
    'device-info': DeviceInfoHelper.getDeviceInfo()
  };

  ///Handle the [response] received from API
  ///So it is moved to a separate function instead of having the same code in both functions
  Future _handleResponse(Response response) async {
    dynamic body = response.body;
    printInfo(info: body.toString());
    try {
      body = json.decode(body);
    } on FormatException {
      /// This exception is thrown when the server side returns HTML format response
      /// due to internal server error
      if (onMessageReceived != null) {
        onMessageReceived!(FailureResponse(
          type: MessageType.error,
          content: response.bodyString!,
        )).call();
      }
      return;
    }
    switch (int.parse(body['result'])) {
      case 0:
        onConnectionSucceed(body).call();
        break;
      case 1:
        if (onMessageReceived != null) {
          try {
            onMessageReceived!(FailureResponse(
                    type: MessageType.error, content: body['message']))
                .call();
          } catch (e) {}
        }
        break;
      case 2:
        if (onMessageReceived != null) {
          onConnectionSucceed(body).call();
          onMessageReceived!(FailureResponse(
                  type: MessageType.warning, content: body['message']))
              .call();
        }
        break;
    }
  }

  Future post(
      {required String url, @required dynamic body, bool json = false}) async {
    print('url: ' + url);
    print('body: ' + jsonEncode(body));
    if (onPreConnect != null) onPreConnect!.call();
    late Response response;
    var sentHeaders = headers;
    sentHeaders.addIf(json, 'content-type', 'application/json');
    response = await GetConnect().post(url, body, headers: sentHeaders);
    if (onPostConnect != null) onPostConnect!.call();
    if (!response.status.connectionError) {
      _handleResponse(response);
      return;
    }
    if (onConnectionFailed != null) {
      onConnectionFailed!.call();
    }
  }
}
