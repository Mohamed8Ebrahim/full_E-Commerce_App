// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:e_commerce/Core/Shared/Failure.dart';

abstract class RegistRepo {
  Future<Either<Failure, dynamic>> post(
    String endPoint, {
    required Map<String, dynamic> data,
  });
}
