import 'package:dartz/dartz.dart' hide Bind;
import 'package:shared/domain/domain.dart';
import 'package:shared/infra/datasources/datasources.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureException, List<ResultEntity>>> getUsers(
      String searchText) async {
    try {
      final list = await datasource.searchText(searchText);
      if (list == null) {
        return Left<FailureException, List<ResultEntity>>(
            DatasourceResultNull());
      }
      if (list.isEmpty) {
        return Left(EmptyList());
      }
      return Right<FailureException, List<ResultEntity>>(list);
    } catch (e) {
      return Left<FailureException, List<ResultEntity>>(ErrorSearch());
    }
  }
}
