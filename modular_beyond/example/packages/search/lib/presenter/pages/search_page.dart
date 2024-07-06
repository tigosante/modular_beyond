import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget _buildList(List<ResultEntity> list) {
    if (list.isEmpty) {
      return Center(
        child: Text('empty_list'.i18n()),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        var item = list[index];
        return ListTile(
          leading: Hero(
            tag: item.image,
            child: CircleAvatar(
              backgroundImage: NetworkImage(item.image),
            ),
          ),
          title: Text(item.nickname),
          onTap: () {
            Modular.to.pushNamed('../details/id=1', arguments: item);
          },
        );
      },
    );
  }

  Widget _buildError(error) {
    if (error is EmptyList) {
      return const Center(
        child: Text('Nothing has been found'),
      );
    } else if (error is ErrorSearch) {
      return const Center(
        child: Text('Github error'),
      );
    } else {
      return Center(child: Text('search_title'.i18n()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<SearchStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text("search_title".i18n()),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
            child: TextField(
              onChanged: store.setSearchText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: store.when(
              onState: _buildList,
              onLoading: (loading) =>
                  const Center(child: CircularProgressIndicator()),
              onError: _buildError,
            ),
          ),
        ],
      ),
    );
  }
}
