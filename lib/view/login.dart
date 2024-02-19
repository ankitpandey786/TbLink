import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hospital/controller/loginController.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return  Container(
      decoration: const BoxDecoration(
        image:  DecorationImage(image: AssetImage('assets/images/login.png'),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 400.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: TextFormField(
                          controller: controller.usernameTextController,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20.sp,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                            ),
                              labelText: "Enter your Username",
                              labelStyle: const TextStyle(color: Colors.black),
                             ),

                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Obx(()=>
                         SizedBox(
                          height: 60.h,
                          child: TextFormField(
                            controller: controller.passwordTextController,
                            obscureText: !controller.ispasswordvisible.value,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 20.sp,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                                  borderSide: BorderSide(
                                    color: Colors.teal.shade100,
                                    width: 2,
                                  )
                              ),
                              labelText: "Enter your Password",
                              labelStyle: const TextStyle(color: Colors.black),
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                icon:!controller.ispasswordvisible.value ? Icon( Icons.visibility,
                                  size: 25.h,
                                  color: Colors.teal.shade100,
                                ) :Icon( Icons.visibility_off,
                                  size: 25.h,
                                  color: Colors.teal.shade100,
                                ) ,
                                onPressed: () {
                                  controller.ispasswordvisible(!controller.ispasswordvisible.value);
                                },
                              ),),

                          ),
                        ),
                      ),
                  SizedBox(height : 30.h),
                  Obx(()=> !controller.isloading.value ?
                     InkWell(
                      onTap: (){controller.login();},
                      child: Container(
                        height: 60.h,
                        width: 400.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(70.r),
                          ),
                          color: Colors.teal.shade100,
                          border: Border.all(
                            color:Colors.teal.shade100,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'login',
                            style: TextStyle(
                                letterSpacing: 0,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp ,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ) :const Center(child: CircularProgressIndicator()),
                  )
                    ],
                  ),

              ),
            )
          ],
        )
      ),
    );
  }
}
