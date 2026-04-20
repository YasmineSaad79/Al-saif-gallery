import 'package:flutter/material.dart';

/// Cache للويدجتات المحملة - يحتفظ بها في الذاكرة
class WidgetCache {
  static final Map<String, Widget> _cache = {};
  
  /// حفظ widget في الـ cache
  static void store(String key, Widget widget) {
    _cache[key] = widget;
  }
  
  /// استرجاع widget من الـ cache
  static Widget? get(String key) {
    return _cache[key];
  }
  
  /// التحقق من وجود widget في الـ cache
  static bool has(String key) {
    return _cache.containsKey(key);
  }
  
  /// مسح الـ cache (اختياري)
  static void clear() {
    _cache.clear();
  }
}
