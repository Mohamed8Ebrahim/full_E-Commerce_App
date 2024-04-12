// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/Core/Shared/Failure.dart';
import 'package:e_commerce/Core/Util/Helper/End_Point.dart';

import 'Regist_Repo.dart';

class RegistRepoImpl implements RegistRepo {
  final Dio dio = Dio()
    ..options.baseUrl = EndPoint.baseUrl
    ..options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
    };
  @override
  Future<Either<Failure, dynamic>> post(String endPoint,
      {required Map<String, dynamic> data}) async {
    try {
      Response response = await dio.post(endPoint, data: data);
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
