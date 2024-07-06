import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class DetailsPage extends StatefulWidget {
  final ResultEntity? result;
  const DetailsPage({
    super.key,
    this.result,
  });
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void dispose() {
    Modular.dispose<SearchStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(Modular.args.queryParams['id'].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.result != null
            ? "details_title".i18n([widget.result!.nickname])
            : 'Make a search'),
      ),
      body: widget.result != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.result!.image,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.result!.image),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: () => Modular.to.pushReplacementNamed('/'),
                child: const Text('Make a search'),
              ),
            ),
    );
  }
}
