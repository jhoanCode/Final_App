// news_provider.dart
import 'package:flutter/material.dart';
import 'news_model.dart';
import 'news_service.dart';

class NewsProvider with ChangeNotifier {
  List<News> _newsList = [];
  bool _isLoading = false;

  List<News> get newsList => _newsList;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      _newsList = await NewsService().fetchNews();
    } catch (error) {
      // Handle error
      _newsList = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
