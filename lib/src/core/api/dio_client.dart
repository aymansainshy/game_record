import 'package:dio/dio.dart';
import 'package:hareeg/src/config/app_model.dart';
import 'package:hareeg/src/core/api/dio_interceptor.dart';
import 'package:hareeg/src/core/api/network_result.dart';
import 'package:hareeg/src/core/api/network_services.dart';

class DioClient extends NetworkServices<Map<String, dynamic>> {
  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppModel.domain,
        receiveTimeout: const Duration(seconds: 5),
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
      ),
    );

    dio.interceptors.add(DioInterceptor(dio));
  }

  late Dio dio;

  @override
  Future<NetworkResult<Map<String, dynamic>>> get(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.get(url);
      return NetworkResultSuccess(data: response.data);
    } on DioException catch (exception) {
      return NetworkResultFailure(error: exception);
    }
  }

  @override
  Future<NetworkResult<Map<String, dynamic>>> post(String url, {Object? data}) async {
    try {
      final response = await dio.post(url, data: data);
      return NetworkResultSuccess(data: response.data);
    } on DioException catch (exception) {
      return NetworkResultFailure(error: exception);
    }
  }

  @override
  Future<NetworkResult<Map<String, dynamic>>> patch(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.patch(url, data: data);
      return NetworkResultSuccess(data: response.data);
    } on DioException catch (exception) {
      return NetworkResultFailure(error: exception);
    }
  }

  @override
  Future<NetworkResult<Map<String, dynamic>>> put(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(url, data: data);
      return NetworkResultSuccess(data: response.data);
    } on DioException catch (exception) {
      return NetworkResultFailure(error: exception);
    }
  }

  @override
  Future<NetworkResult<Map<String, dynamic>>> delete(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete(url, data: data);
      return NetworkResultSuccess(data: response.data);
    } on DioException catch (exception) {
      return NetworkResultFailure(error: exception);
    }
  }
}
