import 'package:flutter/widgets.dart' show BuildContext;

final List<BuildContext> _contextStack = [];
BuildContext get currentContext => _contextStack.last;

void popCurrentContext() {
  _contextStack.removeLast();
}

extension BuildcontextExtension on BuildContext {
  void setCurrentContext() {
    _contextStack.add(this);
  }
}
