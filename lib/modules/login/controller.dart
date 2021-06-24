import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/modules/login/api/login_api.dart';
import 'package:wan_android_getx/routes/app_pages.dart';
import 'package:wan_android_getx/utils/log_utils.dart';

class LoginController extends GetxController {
  var userNameController = TextEditingController();
  var userPwdController = TextEditingController();

  var _api = Get.find<LoginApi>();

  void login() async {
    var userName = userNameController.value.text.trim();
    var userPwd = userPwdController.value.text.trim();

    if (userName.isEmpty) {
      Get.snackbar("提示", "请输入账户名");
      return;
    }

    if (userPwd.isEmpty) {
      Get.snackbar(
        "提示",
        "请输入密码",
      );
      return;
    }

    var data = await _api.login(userName, userPwd);

    if (data != null) {
      Get.offNamed(Routes.HOME);
    }

  }
}
