import 'package:dio/dio.dart';
import 'package:task_manager/common/api/api_endpoints.dart';
import 'package:task_manager/common/utils/cache_helper.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);



  Future<Map<String, dynamic>> get({required String endPoint}) async {
    String? token = CacheHelper.getData(key: 'token');

    var response = await _dio.get(
      '${Endpoints.baseUrl}$endPoint',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, required Map<String, dynamic> data}) async {

    var response = await _dio.post(
      '${Endpoints.baseUrl}$endPoint',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    var response = await _dio.delete('${Endpoints.baseUrl}$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> update(
      {required String endPoint, required Map<String, dynamic> data}) async {
    var response = await _dio.put('${Endpoints.baseUrl}$endPoint', data: data);
    return response.data;
  }
}
