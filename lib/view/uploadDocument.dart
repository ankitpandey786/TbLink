import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hospital/controller/uploadDocumentController.dart';
import 'package:hospital/widgets/appWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UploadDocument extends StatelessWidget {
  //final controller = Get.put(UploadDocumentController(),permanent: true);
  final controller  = Get.find<UploadDocumentController>();
  UploadDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar('Upload Reports',true),
      body: Form(
        key: controller.formKey,
        child: Obx(() => !controller.isloading.value ?
            SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient Name',style: TextStyle(fontSize: 18.sp)),
                  Text(controller.patientId,style: TextStyle(fontSize: 20.sp,color: Colors.teal.shade400),),
                  const Divider(),
                  Text("Select Report Type",style: TextStyle(fontSize: 18.sp)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.sp)
                    ),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))
                      ),
                      hint:const Text('Select your report type'),
                      isExpanded: true,
                          items: controller.documentsType.map<DropdownMenuItem<String>>((m) {
                            return DropdownMenuItem(
                              value: m.rowId.toString(),
                              child: Text(m.type!),
                            );
                          }).toList(),
                          onChanged: (value){
                            controller.documentId(value as String);
                          },
                      validator: (value){

                      },
                      ),
                  ),
                  SizedBox(height: 10.h,),
                  Text('Prepared On',style: TextStyle(fontSize: 18.sp)),
                  TextFormField(
                    controller: controller.preparedon,
                    decoration: InputDecoration(
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp)
                      ),
                      hintText: 'yyyy-MM-dd',
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_month,), onPressed: () async {
                           final DateTime picked = await controller.selectDate(context);
                           controller.preparedon.text = DateFormat('yyyy-MM-dd').format(picked);
                      },)
                    )
                  ),
                  SizedBox(height: 10.h,),
                  Text('Notes',style: TextStyle(fontSize: 18.sp)),
                  TextFormField(
                    controller: controller.notes,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Add your notes here......',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp)
                      )
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade400,
                          borderRadius: BorderRadius.circular(40.sp)
                        ),
                        child: IconButton(
                            onPressed: (){
                              controller.pickFile();
                            },
                            icon: Icon(Icons.attachment_rounded,size: 40.sp,color: Colors.white,)),
                      ),
                      SizedBox(width: 20.w,),
                      Container(
                        height: 60.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade400,
                            borderRadius: BorderRadius.circular(40.sp)
                        ),
                        child: IconButton(
                            onPressed: (){
                              controller.getImage(ImageSource.camera);
                            },
                            icon: Icon(Icons.camera_alt_outlined,size: 40.sp,color: Colors.white,)),
                      ),

                    ],
                  ),
                  Text(controller.fileName.value),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      onPressed: () {
                          controller.addReports(controller.documentId.value,controller.filePath.value,controller.fileName.value,controller.preparedon.text,controller.notes.text);
                      },
                      color: Colors.teal.shade400,
                      child:const Text(
                        'Add',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  // Text(controller.selectedImagePath.value)
                ],
              ),
          ),
            ) : const Center(child: CircularProgressIndicator()),
        ),
      )
    );
  }
}
