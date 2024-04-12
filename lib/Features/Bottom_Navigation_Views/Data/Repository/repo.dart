import 'package:dartz/dartz.dart';
import 'package:e_commerce/Core/Shared/Failure.dart';

abstract class Repo {
  Future<Either<Failure, dynamic>> get(
    String endPoint, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  });
  Future<Either<Failure, dynamic>> post(
    String endPoint, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  });
  Future<Either<Failure, dynamic>> delete(String endPoint);
  Future<Either<Failure, dynamic>> put(
    String endPoint, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  });
}
