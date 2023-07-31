import 'dart:async';

import 'package:rxdart/rxdart.dart';

class TextBloc {
  StreamController<String>  _textController = BehaviorSubject();

  Stream<String> get textStream => _textController.stream;

  dispose() {
    _textController.close();
  }

  updateText(String text) {
    (text == null || text == "")
        ? _textController.sink.addError("Invalid value entered!")
        : _textController.sink.add(text);
  }
}
