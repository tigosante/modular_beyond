// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:modular_beyond/modular_beyond.dart';
import 'package:modular_beyond_example/app/core/config/config.dart';
import 'package:http/http.dart' as http;

import 'search/domain/repositories/search_repository.dart';
import 'search/domain/usecases/search_by_text.dart';
import 'search/external/github/github_search_datasource.dart';
import 'search/infra/datasources/search_datasource.dart';
import 'search/infra/repositories/search_repository_impl.dart';
import 'search/presenter/pages/details_page.dart';
import 'search/presenter/pages/guardt.dart';
import 'search/presenter/pages/search_page.dart';
import 'search/presenter/stores/search_store.dart';

class AppModule extends Module {
  @override
  void translate(Translate t) {
    t.mainModule(alias: "main_module");
  }

  @override
  void binds(i) {
    i.addInstance<http.Client>(http.Client());
    i.add<SearchDatasource>(GithubSearchDatasource.new);
    i.add<SearchRepository>(SearchRepositoryImpl.new);
    i.add<SearchByText>(SearchByTextImpl.new);
    i.addSingleton<SearchStore>(SearchStore.new, config: storeConfig());
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const SearchPage());
    r.child('/details',
        child: (_) => DetailsPage(result: r.args.data), guards: [GuardT()]);
  }
}
