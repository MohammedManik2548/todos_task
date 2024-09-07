import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos_task/bindings/general_bindings.dart';
import 'package:todos_task/routes/app_routes.dart';
import 'package:todos_task/routes/routes.dart';
import 'core/theme/app_them.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      initialRoute: RouteStrings.tasks,
      getPages: AppRoutes.pages,
    );
  }
}
