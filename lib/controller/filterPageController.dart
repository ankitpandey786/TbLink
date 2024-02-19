import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospital/api/dioClient.dart';
import 'package:hospital/models/patientListModel.dart';
import 'package:hospital/utils/appConstants.dart';
import 'package:hospital/utils/auth.dart';

import '../utils/helperFile.dart';

class FilterPageController extends GetxController
{
  TextEditingController searchText = TextEditingController();

  RxBool isloading = false.obs;
  RxList<Welcome> data = RxList([]);
  FilterPageController()
  {
    getListOfPatient();
  }

  Future<dynamic> getListOfPatient() async
  {
    Dio dio = await DioClient.get();
    try{
      isloading(true);
      data = RxList([]);
      var response = await dio.get(AppConstants.baseUrl + AppConstants.allPatientUrl,
      //     options: Options(headers: {
      //   'Authorization' : 'Bearer ${AuthServices.authenticationToken}',
      // })
      );
      data.addAll(Data.fromJSON(response.data).data!.sublist(1,10));
    }
    catch(e)
    {
      showError(e.toString());
    }
    finally{
      isloading(false);
    }
  }

  Future<dynamic> getSearchedListOfPatient(String value) async
  {
    Dio dio = await DioClient.get();
    var datamap = {
      "FilterPredicate": value
    };
    try{
      isloading(true);
      var response = await dio.get(AppConstants.baseUrl + AppConstants.filter,data: datamap,
      //     options: Options(headers: {
      //   'Authorization' : 'Bearer ${AuthServices.authenticationToken}',
      // })
      );
      data = RxList([]);
      data.addAll(Data.fromJSON(response.data).data!);
    }
    catch(e)
    {
      showError(e.toString());
    }
    finally{
      isloading(false);
    }
  }
}