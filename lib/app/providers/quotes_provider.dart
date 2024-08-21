import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/services/quotes_service.dart';

class QuotesProvider with ChangeNotifier {
  List<Quote> _quotes = [];
  bool _isQuoteVisible = false;
  bool _isOpaque = false;
  bool _isHandIconVisible = true;
  bool _isLoading = false;
  String _errorMessage = '';

  List<Quote> get quotes => _quotes;
  bool get isQuoteVisible => _isQuoteVisible;
  bool get isOpaque => _isOpaque;
  bool get isHandIconVisible => _isHandIconVisible;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void showQuoteOnTap() {
    _isQuoteVisible = !_isQuoteVisible;
    _isOpaque = !_isOpaque;
    _isHandIconVisible = false;

    notifyListeners();
  }

  void resetToInitialState() {
    _isQuoteVisible = false;
    _isOpaque = false;
    _isHandIconVisible = true;
  }

  Future<void> fetchData() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final client = http.Client();
      _quotes = await fetchQuotes(client);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
