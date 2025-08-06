import 'package:get/get.dart';
import '../core/classes/crud.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(Crud());
  }

}