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
    _contextStack.add(this);
  }
}
