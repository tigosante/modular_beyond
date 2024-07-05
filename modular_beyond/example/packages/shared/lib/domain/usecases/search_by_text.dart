import 'package:dartz/dartz.dart' hide Bind;
import 'package:shared/domain/domain.dart';

mixin SearchByText {
  Future<Either<FailureException, List<ResultEntity>>> call(String textSearch);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureException, List<ResultEntity>>> call(
      String? textSearch) async {
    if (textSearch?.isEmpty ?? true) {
      return Left(InvalidSearchText());
    }
    return await repository.getUsers(textSearch!);
  }
}
