import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared/infra/datasources/datasources.dart';
import 'package:shared/infra/models/models.dart';

class GithubSearchDatasource implements SearchDatasource {
  final Client client;

  GithubSearchDatasource(this.client);

  @override
  Future<List<ResultModel>?> searchText(String textSearch) async {
    var url = Uri.parse('https://api.github.com/search/users?q=$textSearch');
    var result = await client.get(url);
    if (result.statusCode == 200) {
      final json = jsonDecode(result.body);
      debugPrint('execute datasource');
      var jsonList = json['items'] as List;
      var list = jsonList
          .map((item) => ResultModel(
              name: '',
              nickname: item['login'],
              image: item['avatar_url'],
              url: item['url']))
          .toList();
      return list;
    } else {
      throw Exception();
    }
  }
}
