import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:shared/domain/entities/result_entity.dart';
import 'package:shared/domain/usecases/search_by_text.dart';

class SearchStore extends Store<List<ResultEntity>> {
  final SearchByText searchByText;

  SearchStore(this.searchByText) : super([]);

  Timer? timer;

  void setSearchText(String value) {
    setLoading(true);
    timer?.cancel();

    timer = Timer(const Duration(milliseconds: 500), () {
      searchByText(value).then((value) => value.fold(setError, update));
    });
  }
}
