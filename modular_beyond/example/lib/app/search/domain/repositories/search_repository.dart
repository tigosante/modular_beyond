import 'package:dartz/dartz.dart';
import 'package:modular_beyond_example/app/search/domain/entities/result.dart';
import 'package:modular_beyond_example/app/search/domain/errors/erros.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Result>>> getUsers(String searchText);
}
