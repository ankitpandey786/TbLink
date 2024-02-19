import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hospital/controller/filterPageController.dart';
import 'package:hospital/view/reportsToupload.dart';
import 'package:hospital/widgets/appWidget.dart';
import 'package:hospital/widgets/cardDetails.dart';

class FilterPage extends StatelessWidget {

  final controller = Get.put(FilterPageController());
  FilterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Patient List',false),
      body: SingleChildScrollView(
        child: WillPopScope(
          onWillPop: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Alert"),
                content: const Text("Are you sure you want to exit?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:const Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: const Text("Yes"),
                  ),
                ],
              ),
            );
            return true;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w
            ),
            child: Obx(() => !controller.isloading.value ?
                Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.searchText,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                              ),
                            hintText: 'Search by id or number',
                           // suffixIcon:const Icon(Icons.search)
                          ),
                          onChanged: (val){
                            if(val.isEmpty || val == "")
                              {
                                controller.getListOfPatient();
                              }
                          },
                        ),
                      ),
                      IconButton(onPressed: (){
                        controller.getSearchedListOfPatient(controller.searchText.value.text);
                      }, icon:const Icon(Icons.search))
                    ],
                  ),
                  SizedBox(height: 20.h),
                  ListView.separated(
                    primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context,index)
                      {
                        return  InkWell(
                          onTap: (){
                            Get.to(() => ReportToUpload() ,arguments: [controller.data[index].kMedId,controller.data[index].rowId]);
                          },
                          child: Card(
                            color: Colors.teal.shade100,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CardDetails(
                                          title: 'Patient id',
                                          textColor: Colors.blueGrey,
                                          titleSize: 18.sp,
                                          SubtitleSize: 16.sp,
                                          value:controller.data[index].kMedId ?? "",
                                          isRight: false,
                                          isNextLine: true,
                                          isCommonColor: false,
                                        ),
                                        const Spacer(),
                                        CardDetails(
                                          title: 'Gender',
                                          textColor: Colors.blueGrey,
                                          titleSize: 18.sp,
                                          SubtitleSize: 16.sp,
                                          value:controller.data[index].gender == "m" ? "Male" : "Female",
                                          isRight: true,
                                          isNextLine: true,
                                          isCommonColor: false,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Center(child: Text(controller.data[index].firstName?? "",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),)),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        CardDetails(
                                          title: 'Contact Number',
                                          textColor: Colors.blueGrey,
                                          titleSize: 18.sp,
                                          SubtitleSize: 16.sp,
                                          value: controller.data[index].contactDetail!.mobileNo?.toStringAsFixed(0),
                                          isRight: false,
                                          isNextLine: true,
                                          isCommonColor: false,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      children: [
                                        CardDetails(
                                          title: 'Address',
                                          textColor: Colors.blueGrey,
                                          titleSize: 18.sp,
                                          SubtitleSize: 16.sp,
                                          value:controller.data[index].contactDetail!.address ?? "",
                                          isRight: false,
                                          isNextLine: true,
                                          isCommonColor: false,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            // child: ListTile(
                            //   leading: Text(controller.data[index].kMedId ?? "",style: TextStyling.idTextStyle,),
                            //   title: Text(controller.data[index].firstName! + " " + controller.data[index].lastName!,style: TextStyling.title,),
                            //   subtitle: Text(controller.data[index].contactDetail!.address == null ? "" : controller.data[index].contactDetail!.address!,),
                            //   trailing: Text(controller.data[index].contactDetail!.mobileNo == null ? "" : controller.data[index].contactDetail!.mobileNo.toString(),),
                            // ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: 10.h,);
                      },
                      itemCount: controller.data.length
                  )
                ],
              ) :const Center(child:  CircularProgressIndicator()),
            ),
          ),
        ),
      )
    );
  }
}
