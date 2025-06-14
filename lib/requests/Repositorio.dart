import 'dart:convert';

import 'package:controle_sensor_de_fogo/models/Sensor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SensorCache {
  static const String _key = 'sensor_list';

  static Future<void> saveSensors(List<Sensor> sensors) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> sensorJsonList =
        sensors.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList(_key, sensorJsonList);
  }

  static Future<List<Sensor>> loadSensors() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? sensorJsonList = prefs.getStringList(_key);
    if (sensorJsonList == null) return [];

    return sensorJsonList
        .map((jsonStr) => Sensor.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  /// Limpa os sensores do cache
  static Future<void> clearSensors() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
