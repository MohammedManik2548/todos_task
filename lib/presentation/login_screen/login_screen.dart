import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/validators/app_validator.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(title: Text('Login')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: EdgeInsets.only(top: 60),
        child: Form(
          key: authController.formKey,
          child: Column(
            children: [
              Image.asset(
                width: width*0.6,
                  'assets/login.png',
              ),
              SizedBox(height: 30),
              Material(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: TextFormField(
                    controller: authController.emailController,
                    validator: (value) => AppValidator.validateEmptyText('Email', value),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Material(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: TextFormField(
                      obscureText: authController.hidePassword.value,
                      controller: authController.passwordController,
                      validator: (value) => AppValidator.validatePassword(value),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => authController.hidePassword.value =
                              !authController.hidePassword.value,
                          icon: Icon(authController.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye),
                        ),
                        labelText: 'Password',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              // TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              // TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password')),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      if (authController.formKey.currentState!.validate()) {
                        authController.login();
                      }
                    },
                    child: Text('Login')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
