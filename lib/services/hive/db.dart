import 'package:hive/hive.dart';

import 'data_provider.dart';

/// Concrete implementation for local hive data provider
class HiveDataProvider implements LocalDataProviderContract {
  static final HiveDataProvider _instance = HiveDataProvider._();
  factory HiveDataProvider() => _instance;
  HiveDataProvider._();

  @override
  Future deleteData(
    String table, {
    String? whereClauseValue,
    List whereClauseArgs = const [],
    List<String> keys = const [],
  }) async {
    Box box = await _getBox(table);
    // empty box
    if (keys.isEmpty) {
      await box.clear();
      return;
    }
    await Future.wait(keys.map((key) => box.delete(key)));
    for (var key in keys) {
      box.delete(key);
    }
  }

  @override
  Future<void> insertData(String table, Map<dynamic, dynamic> values) async {
    Box box = await _getBox(table);
    if (values.isNotEmpty) {
      values.forEach((k, v) => box.put(k, v));
    }
  }

  @override
  Future<Map<String, dynamic>> readData(
    String table, {
    bool? distinct,
    List<String> keys = const [],
    List<String> columns = const [],
    String? whereClauseValue,
    List? whereClauseArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
  }) async {
    Box box = await _getBox(table);
    if (keys.isEmpty) {
      return Map<String, dynamic>.from(box.toMap());
    }
    Map<String, dynamic> data = {};
    for (var k in keys) {
      data[k] = box.get(k);
    }
    return data;
  }

  @override
  Future updateData(
    String table,
    Map<String, dynamic> values, {
    String? whereClauseValue,
    List whereClauseArgs = const [],
  }) async {
    Box box = await _getBox(table);
    if (values.isNotEmpty) {
      values.forEach((k, v) => box.put(k, v));
    }
    return null;
  }

  /// Open and return hive box
  Future<Box> _getBox(String boxName) async {
    Box box;
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox(boxName);
    } else {
      box = Hive.box(boxName);
    }
    return box;
  }
}
