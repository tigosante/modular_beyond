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
    if (_contextStack.isNotEmpty) {
      if (_contextStack.last.widget.hashCode == widget.hashCode) {
        return;
      }
    }
    _contextStack.add(this);
  }
}
