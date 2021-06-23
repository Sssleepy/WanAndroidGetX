/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-11 01:38:08
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/utils/dependency_injection.dart
 */
import 'package:get/get.dart';
import 'package:wan_android_getx/app/providers/dio_service.dart';
import 'package:wan_android_getx/app/providers/sp_service.dart';
import 'package:wan_android_getx/http/net/dio_new.dart';


/// 依赖注入
class DependencyInjection {
  static Future<void> init() async {
    // shared_preferences
    await Get.putAsync(() => AppSpController().init());
    // dio配置信息
    await Get.putAsync(() => DioConfigController().init());
    //  网络请求
    Get.put(HttpClient());
  }
}
