// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import '../components/cupertino/customdropdown.dart';
import '../modules/addproperty/addpropertyviewmodel.dart';
import '../modules/more/moreviewmodel.dart';

init() {
  final _ = Get.put(AddPropertyViewModel());
  final __ = Get.put(MoreViewModel());
  final ___ = Get.put(FullScreeController());
}
