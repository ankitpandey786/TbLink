

import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/models/documentType.dart';
import 'package:hospital/utils/appConstants.dart';
import 'package:hospital/utils/auth.dart';
import 'package:hospital/utils/helperFile.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocumentController extends GetxController
{
  late String patientId ;
  late int rowid;
  final formKey = GlobalKey<FormState>();
  RxBool isloading = RxBool(false);
  RxString fileName = RxString('');
  RxString filePath = RxString('');
  RxString documentId = RxString('');
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  final TextEditingController preparedon = TextEditingController();
  final TextEditingController notes = TextEditingController();
  RxList<DocumentTypeModel> documentsType =  RxList([]);
  RxList documentsToUpload = RxList([]);

  UploadDocumentController()
  {
    patientId = Get.arguments[0];
    rowid = Get.arguments[1];
    getDocumentType();
  }

  void getImage(ImageSource imageSource) async
  {
     final pickedFile  = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if(pickedFile != null)
      {
        selectedImagePath.value = pickedFile.path;
        print(selectedImagePath.value);
        fileName('camerareport.jpg');
        filePath(selectedImagePath.value);
      }
    else
      {
        Get.snackbar("Error", "No image picked");
      }
  }


  Future<dynamic> getDocumentType() async
  {
    isloading(true);
    d.Dio dio = d.Dio();
    try{
      var response = await dio.get(AppConstants.baseUrl + AppConstants.getDocumentsType,options: Options(headers: {
        'Authorization' : 'Bearer ${AuthServices.authenticationToken}',
      }));
      documentsType.addAll(Data.fromJSON(response.data).data!);
      print(documentsType);
      isloading(false);
    }
    catch(e)
    {
      showError(e.toString());
    }
  }

  void pickFile() async
  {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    fileName(result.files.first.name);
    filePath(result.files.first.path);

    // Read the file as bytes
    final file = File(result.files.first.path!).readAsBytes();
    print(file);
    //d.MultipartFile.fromFile(result.files.first.path!,filename:result.files.first.name);

  }

  Future<dynamic> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return picked;
    }
    return null;
  }

  void addReports(String documentIds,String filePath,String fileNames,String preparedOn,String note){
    var obj = {
          'documentsId' : documentIds,
          'filePath' : filePath,
          'fileName' : fileNames,
          'preparedOn' : preparedOn,
          'notes' : note
    };
    documentsToUpload.add(obj);
    print(documentsToUpload);
    Get.back();
    preparedon.clear();
    notes.clear();
    fileName('');
    documentId('');

  }

  Future<dynamic> submitReports() async
  {
    isloading(true);
    d.Dio dio = d.Dio();
    dio.options.headers["Authorization"] = 'Bearer ${AuthServices.authenticationToken}';

    Map<String, dynamic> data = {
      "PatientID": rowid,
    };
    for(int i=0;i< documentsToUpload.length;i++)
      {
        String keyPrefix = "Documents[$i].";
        data['${keyPrefix}DocumentType'] = documentsToUpload[i]['documentsId'];
        data['${keyPrefix}PreparedOn'] = documentsToUpload[i]['preparedOn'];
        data['${keyPrefix}Note'] = documentsToUpload[i]['notes'];

      }

    d.FormData formData = d.FormData.fromMap(data);
    for(int i = 0; i < documentsToUpload.length;i++)
      {
        String keyPrefix = "Documents[$i].";
        formData.files.add(MapEntry(
            '${keyPrefix}File',
            await d.MultipartFile.fromFile(
                documentsToUpload[i]['filePath'],
                filename: documentsToUpload[i]['fileName'])));
      }
    try{
      var response = await dio.post(AppConstants.baseUrl + AppConstants.uploadDocuments, data: formData,options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },));
      showSuccess(response.data['message']);
      isloading(false);
      Get.back();

    }
    catch(e)
    {
      showError(e.toString());
    }
  }

}