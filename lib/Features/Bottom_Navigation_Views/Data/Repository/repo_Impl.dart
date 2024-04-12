// ignore_for_file: file_names, avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/Core/Util/Helper/End_Point.dart';
import 'package:e_commerce/Core/Shared/Failure.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Data/Repository/repo.dart';

class RepoImpl implements Repo {
  late Dio dio;
  RepoImpl() {
    dio = Dio()
      ..options
      ..interceptors.add(
        LogInterceptor(
          error: true,
          logPrint: (object) => print(object),
          request: true,
        ),
      );
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': token!,
    };
  }

  @override
  Future<Either<Failure, dynamic>> get(
    String endPoint, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response =
          await dio.get(endPoint, queryParameters: query, data: data);
      return right(response.data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> post(String endPoint,
      {Map<String, dynamic>? query, Map<String, dynamic>? data}) async {
    try {
      Response response =
          await dio.post(endPoint, data: data, queryParameters: query);
      return right(response.data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> delete(String endPoint) async {
    try {
      Response response = await dio.delete(endPoint);
      return right(response.data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> put(
    String endPoint, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response =
          await dio.put(endPoint, data: data, queryParameters: query);
      return right(response.data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
