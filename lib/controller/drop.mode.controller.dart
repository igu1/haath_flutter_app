import 'package:disaster_management_app/enum/SelectionType.dart';
import 'package:get/get.dart';

class DropModeController extends GetxController {


  final currentSelectionMethod = SelectionType.NONE.obs;
  
  String getIcon() {
    final type = currentSelectionMethod.value;
    if (type == SelectionType.DANGER_ZONE) {
      return 'danger_icon';
    } else if (type == SelectionType.REQUEST_DROP) {
      return 'request_drop';
    } else if (type == SelectionType.REQUEST_PICKUP) {
      return 'request_pickup';
    } else if (type == SelectionType.SUPPLY_DROP) {
      return 'supply_drop';
    } else if (type == SelectionType.WATER_SOURCE) {
      return 'water_source';
    } else if (type == SelectionType.SAFE_ZONE) {
      return 'safe_zone';
    } else if (type == SelectionType.WARNING_ZONE) {
      return 'warning_zone';
    } else {
      return '';
    }
  }


}