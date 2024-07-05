import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

BindConfig<T> storeConfig<T extends Store>() {
  return BindConfig<T>(
    onDispose: (value) => value.destroy(),
    notifier: (value) => Listenable.merge(
        [value.selectError, value.selectLoading, value.selectState]),
  );
}
