import 'package:shared/shared.dart';
import 'package:user_details/presenter/guards/guardt.dart';
import 'package:user_details/presenter/pages/details_page.dart';

class UserDetailsModule extends Module {
  @override
  void translate(Translate t) {
    // o mesmo se aplica aqui.
    // chamando dessa forma você está dizendo pro serviço que as configurações serão iguais as padrões.
    // caso não tenha configuração padrão, será apresentado um erro no console em caso de debug.
    // em prod esse module será ignorado.
    t.module("user_details");

    //

    /// Sempre que um novo module for iniciado pela aplicação, o serviço entenderá o contexto
    /// e usará a chave desse contexto para buscar as traduções.
    /// Ex: "user_details": { "details_title": "%s details" }
    /// "details_title".translate(["User"]) => "User details"
    ///
    /// Ao sair do contexto / module, será feito o dispose dessa chave e a chave anterior (caso exista)
    /// será usada.
    ///
    /// Caso esse seja o module principal a chave se mantem.
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
