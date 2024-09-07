import 'package:get/get.dart';
import '../presentation/login_screen/auth_controller.dart';
import '../presentation/task_list_screen/task_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(TaskController());
  }
}