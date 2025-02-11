import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio;

  // Singleton pattern
  static final ApiProvider _instance = ApiProvider._internal();
  
  factory ApiProvider() {
    return _instance;
  }

  ApiProvider._internal() : _dio = Dio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status! < 500;
      },
    );

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<dynamic> fetchJsonData(String url) async {
    try {
      final Response response = await _dio.get(url);
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: url),
          response: response,
          message: 'Failed to load JSON data: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      
      throw _handleDioError(e);
    } catch (e) {
     
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout');
      case DioExceptionType.connectionError:
        return Exception('No internet connection');
      case DioExceptionType.badResponse:
        return Exception('Server error: ${e.response?.statusCode}');
      default:
        return Exception('Network error occurred: ${e.message}');
    }
  }
}