import 'package:flutter/material.dart';
import 'package:modular_beyond/modular_beyond.dart';
import 'package:flutter_triple/flutter_triple.dart';

BindConfig<T> storeConfig<T extends Store>() {
  return BindConfig<T>(
    onDispose: (value) => value.destroy(),
    notifier: (value) => Listenable.merge(
        [value.selectError, value.selectLoading, value.selectState]),
  );
}
