import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  bool _isArabic = false;

  bool get isArabic => _isArabic;
  String get languageCode => _isArabic ? 'ar' : 'en';
  TextDirection get textDirection => _isArabic ? TextDirection.rtl : TextDirection.ltr;

  void toggleLanguage() {
    _isArabic = !_isArabic;
    notifyListeners();
  }
}




