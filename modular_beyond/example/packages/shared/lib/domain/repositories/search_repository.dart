import 'package:dartz/dartz.dart';
import 'package:shared/domain/domain.dart';

abstract class SearchRepository {
  Future<Either<FailureException, List<ResultEntity>>> getUsers(
      String searchText);
}
