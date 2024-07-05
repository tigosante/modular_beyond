import 'package:search/presenter/pages/search_page.dart';
import 'package:shared/shared.dart';
import 'package:user_details/user_details.dart';

class SearchModule extends Module {
  @override
  void translate(Translate t) {
    t.module("search");
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const SearchPage());
    r.module('/details', module: UserDetailsModule());
  }
}
