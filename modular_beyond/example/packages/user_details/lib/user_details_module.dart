import 'package:shared/shared.dart';
import 'package:user_details/presenter/guards/guardt.dart';
import 'package:user_details/presenter/pages/details_page.dart';

class UserDetailsModule extends Module {
  @override
  void translate(Translate t) {
    t.module("user_details");
  }

  @override
  void routes(r) {
    r.child(
      '/:id',
      child: (_) => DetailsPage(result: r.args.data),
      guards: [GuardT()],
    );
  }
}
