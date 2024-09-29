import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _temp = prefs.getDouble('ff_temp') ?? _temp;
    });
    _safeInit(() {
      _weatherIcon = prefs.getString('ff_weatherIcon') ?? _weatherIcon;
    });
    _safeInit(() {
      _weatherDescription =
          prefs.getString('ff_weatherDescription') ?? _weatherDescription;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  double _temp = 0.0;
  double get temp => _temp;
  set temp(double value) {
    _temp = value;
    prefs.setDouble('ff_temp', value);
  }

  String _weatherIcon = '';
  String get weatherIcon => _weatherIcon;
  set weatherIcon(String value) {
    _weatherIcon = value;
    prefs.setString('ff_weatherIcon', value);
  }

  String _weatherDescription = '';
  String get weatherDescription => _weatherDescription;
  set weatherDescription(String value) {
    _weatherDescription = value;
    prefs.setString('ff_weatherDescription', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
