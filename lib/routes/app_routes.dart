import 'package:get/get_navigation/src/routes/get_route.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/task_list_screen/task_list.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/login', page: () => LoginScreen()),
    // GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/tasks', page: () => TaskListScreen()),
    // GetPage(name: '/add-task', page: () => AddTaskScreen(isEdit: false,)),
  ];
}