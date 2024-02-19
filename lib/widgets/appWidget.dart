import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommonAppBar extends AppBar {
  String title1;
  bool isFirstpage;

  CommonAppBar(this.title1,this.isFirstpage, {Key? key}) :super(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light),
    backgroundColor: Colors.teal.shade100,
    toolbarHeight: 66.h,
    centerTitle: true,
    leading:isFirstpage ? IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        size: 30.sp,
        color: Colors.black,
      ),
    ) : SizedBox.shrink(),
    title: Text(
      title1,
      style: TextStyle(color: Colors.black),
      overflow: TextOverflow.ellipsis,
    ),
    ///////
    elevation: 0.0,
    automaticallyImplyLeading: false,
    actions: <Widget>[
      IconButton(
        icon: Icon(
          FontAwesomeIcons.bars,
          size: 30.sp,
          color: Colors.black,
        ),
        onPressed: () {},
        // onPressed: () => callback!(),
      ),
    ],
  );
}
