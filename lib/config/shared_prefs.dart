import 'package:shared_preferences/shared_preferences.dart';

const String _priceList = 'price-list';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setPriceList(String value) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setString(_priceList, value);
    }
  }

  String get priceList =>
      _sharedPrefs?.getString(_priceList) ?? 'Battery Pricelist';

  Future<bool> deleteEverything() async {
    if (_sharedPrefs != null) {
      final result = await _sharedPrefs?.clear();
      return result ?? false;
    }
    return false;
  }
}
