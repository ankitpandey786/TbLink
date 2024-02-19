

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hospital/view/uploadDocument.dart';
import 'package:hospital/widgets/appWidget.dart';
import 'package:hospital/controller/uploadDocumentController.dart';

class ReportToUpload extends StatelessWidget {
  ReportToUpload({Key? key}) : super(key: key);
  final controller = Get.put(UploadDocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Reports',true),
      body: SingleChildScrollView(
        primary: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
          child:  Column(
            children: [
              InkWell(
                onTap: (){
                  Get.to(() => UploadDocument(),arguments: [controller.patientId,controller.rowid]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:Colors.teal.shade400,
                    borderRadius: BorderRadius.circular(10.sp)
                  ),
                  height: 50.h,
                  width: 200.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add More Reports",style: TextStyle(color: Colors.black,fontSize: 20.sp),),
                      SizedBox(width: 10.w,),
                      Icon(Icons.add,size: 20.sp,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),

              Obx(()=> controller.documentsToUpload.isNotEmpty ?
                  ListView.separated(
                  primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context,index)
                    {
                      return ListTile(
                        tileColor: Colors.teal.shade100,
                        title: Text(controller.documentsType[int.parse(controller.documentsToUpload[index]['documentsId'])-1].type!,),
                        subtitle: Text(controller.documentsToUpload[index]['fileName'].toString()),
                        trailing: IconButton(
                          onPressed: (){
                            controller.documentsToUpload.removeAt(index);
                          },
                          icon: const Icon(Icons.delete_forever),),
                      );
                    },
                    separatorBuilder: (context,index)
                    {
                      return SizedBox(height: 10.h,);
                    },
                    itemCount:controller.documentsToUpload.length ) :
                        Center(child: Text('There are no reports to Submit',style: TextStyle(color: Colors.teal.shade400,fontWeight: FontWeight.bold,fontSize: 20.sp),)),
              ),
              SizedBox(height: 20.h,),
              Obx(() => controller.documentsToUpload.isNotEmpty ?
                InkWell(
                  onTap: (){
                    controller.submitReports();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color:Colors.teal.shade400,
                        borderRadius: BorderRadius.circular(10.sp)
                    ),
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Submit",style: TextStyle(color: Colors.black,fontSize: 20.sp),),
                      ],
                    ),
                  ),
                ) :const  SizedBox.shrink(),
              ),
            ],
          )
        ),
      ),
    );
  }
}
