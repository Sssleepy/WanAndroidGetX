import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wan_android_getx/const/constants.dart';
import 'package:wan_android_getx/modules/login/page.dart';

import 'controller.dart';

class MinePage extends StatelessWidget {
  final MineController controller = Get.put(MineController());


  @override
  Widget build(BuildContext context) {
    return GetX<MineController>(
      init: controller,
      initState: (_) {
        controller.initData();
      },
      builder: (controller) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            GestureDetector(
              onTap: () => controller.getBingImg(),
              onDoubleTap: () => controller.getBingImg(isReset: true),
              child: CachedNetworkImage(
                height: 250.h,
                imageUrl: controller.getImageSrc,
                placeholder: (context, url) => LoadingState(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _buildGaussianBlur(context),
                      _buildLevelTag(context),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        _buildUserName(context),
                        Container(
                          margin: EdgeInsets.only(top: 80.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 25.h),
                          decoration: BoxDecoration(
                            color: context.canvasColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () => Get.toNamed(Routes.COLLECT),
                                title: Text(
                                  "收藏",
                                  style: TextStyle(color: context.shadowColor),
                                ),
                                leading: Icon(
                                  CupertinoIcons.collections,
                                  color: context.accentColor,
                                ),
                                trailing: Icon(
                                  CupertinoIcons.right_chevron,
                                  size: 20,
                                ),
                              ),
                              Divider(height: 5.h),
                              ListTile(
                                onTap: () => Get.toNamed(Routes.SETTING),
                                title: Text(
                                  "设置",
                                  style: TextStyle(color: context.shadowColor),
                                ),
                                leading: Icon(
                                  CupertinoIcons.settings,
                                  color: context.accentColor,
                                ),
                                trailing: Icon(
                                  CupertinoIcons.right_chevron,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildUserInfo(context),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Neumorphic _buildUserInfo(BuildContext context) {

    Widget buildInfo(String content, String title, GestureTapCallback onTap) {
      return GestureDetector(
        onTap: controller.localLogin.isLogin.value ? onTap : null,
        child: Container(
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleText(content),
              Container(
                width: 8.w,
                height: 2.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors.secondColor),
              ),
              thirdText(title),
            ],
          ),
        ),
      );
    }

    return Neumorphic(
      margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 55.h),
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          depth: 2,
          shadowDarkColor: context.accentColor,
          lightSource: LightSource.topLeft,
          color: context.primaryColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        height: 35.h,
        decoration: BoxDecoration(
          color: context.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildInfo(
                  "${controller.integralEntity.coinCount ?? "???"}",
                  "积分",
                  () => Get.toNamed(Routes.INTEGRAL),
                ),
                VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                ),
                buildInfo(
                  "${controller.integralEntity.rank ?? "???"}",
                  "排名",
                  () => Get.toNamed(Routes.RANK),
                ),
              ],
            ),
            controller.loadState.value == LoadState.LOADING
                ? LoadingState()
                : Container(),
          ],
        ),
      ),
    );
  }

  Padding _buildUserName(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            depth: 1,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            lightSource: LightSource.bottomRight,
            color: Colors.transparent),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
                  ),
                  child: Container(),
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.localLogin.isLogin.value
                  ? null
                  : () => Get.bottomSheet(LoginPage()),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                child: Text(
                  "${controller.integralEntity.username ?? "去登录"}",
                  style: TextStyle(color: context.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Neumorphic _buildLevelTag(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        depth: 1,
        lightSource: LightSource.bottomRight,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 18.h,
        width: 45.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0,
                0.9
              ],
              colors: [
                AppColors.secondColor,
                context.accentColor,
              ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              R.ASSETS_IMAGES_LEVEL_SVG,
              color: context.primaryColor,
              height: 12.r,
              width: 12.r,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Text(
                "${controller.integralEntity.level ?? "???"}",
                style: TextStyle(color: context.primaryColor, fontSize: 12.sp),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 用背景部分高斯模糊来代替头像
  Widget _buildGaussianBlur(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 70.h, bottom: 5.h),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4)),
            height: 80.r,
            width: 80.r,
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1,
                  sigmaY: 1,
                ),
                child: Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
