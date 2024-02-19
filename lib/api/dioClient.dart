import 'package:dio/dio.dart';
import 'package:hospital/utils/appConstants.dart';
import 'package:hospital/utils/auth.dart';
import 'package:hospital/utils/helperFile.dart';

class DioClient
{
  DioClient._();

  static Future<Dio> get({String contentType = "application/json"}) async { 
  final Dio dio = Dio();

  dio.interceptors.clear();
  if(AuthServices.authenticationToken.isEmpty)
    {
      await getAccessToken(AuthServices.userID, AuthServices.password);
    }
  dio.interceptors.add(
    InterceptorsWrapper(onRequest: (RequestOptions options,handler) async
        {
          options.headers['Authorization'] = "Bearer ${AuthServices.authenticationToken}";
          options.headers["Content-Type"] = contentType;
          return handler.next(options);
        },
        onResponse: (Response response, handler) {
          return handler.resolve(response);
        },
      onError: (DioError error, handler) async
        {
          showError(error.toString());
        }
        )
  );

  return dio;

  }
  
  static Future<dynamic> getAccessToken(String userid, String password) async
  {
    AuthServices.userID = userid;
    AuthServices.password = password;
    Dio dio = Dio();
    var data = {
      "UserId": userid,
      "Password": password
    };
    var response = await dio.post(AppConstants.baseUrl + AppConstants.loginUrl,data: data);
    if(response.statusCode == 200)
      {
        AuthServices.authenticationToken = response.data['token'];
        return response;
      }
  }


}