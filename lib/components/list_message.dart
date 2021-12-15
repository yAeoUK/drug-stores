import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ListMessage extends GetView {
  final String message;

  ListMessage(this.message);

  @override
  Widget build(BuildContext context) => Center(child: Text(message));
}
