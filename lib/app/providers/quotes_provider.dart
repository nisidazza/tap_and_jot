import 'package:flutter/material.dart';

class QuotesProvider with ChangeNotifier {
  bool _shouldDisplay = false;
  bool _isOpaque = false;
  bool _isHandIconVisible = true;

  bool get shouldDisplay => _shouldDisplay;
  bool get isOpaque => _isOpaque;
  bool get isHandIconVisible => _isHandIconVisible;

  void showQuoteOnTap() {
    _shouldDisplay = !_shouldDisplay;
    _isOpaque = !_isOpaque;
    _isHandIconVisible = false;

    notifyListeners();
  }
}
