import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/api/dioClient.dart';
import 'package:hospital/utils/helperFile.dart';
import 'package:hospital/view/filterPage.dart';

class LoginController extends GetxController
{
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  RxBool ispasswordvisible = RxBool(false);
  RxBool isloading = RxBool(false);

  void login() async
  {
    try {
      isloading(true);
      var response = await DioClient.getAccessToken(
          usernameTextController.text.trim(),
          passwordTextController.text.trim());
      if (response.statusCode == 200) {
        showSuccess('You are successfully logged In');
        Get.to(() => FilterPage());
      }
    }
    catch(e){
      showError('User id or password is wrong');
    }
    finally
        {
          usernameTextController.clear();
          passwordTextController.clear();
          isloading(false);
        }
  }
}