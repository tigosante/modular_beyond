import 'package:flutter/widgets.dart' show BuildContext;

final List<BuildContext> _contextStack = [];
BuildContext get currentContext => _contextStack.last;

void popCurrentContext() {
  if (_contextStack.length > 1) {
    _contextStack.removeLast();
  }
}

extension BuildcontextExtension on BuildContext {
  void setCurrentContext() {
    if (_contextStack.isNotEmpty &&
        _contextStack.last.toString() == toString()) {
      return;
    }
    _contextStack.add(this);
  }
}
