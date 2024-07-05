import 'package:core/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared/domain/usecases/search_by_text.dart';
import 'package:shared/infra/infra.dart';
import 'package:shared/shared.dart';

class SharedModule extends Module {
  @override
  void exportedBinds(i) {
    i.addInstance<http.Client>(http.Client());
    i.add<SearchDatasource>(GithubSearchDatasource.new);
    i.add<SearchRepository>(SearchRepositoryImpl.new);
    i.add<SearchByText>(SearchByTextImpl.new);
    i.addSingleton<SearchStore>(SearchStore.new, config: storeConfig());
  }
}
