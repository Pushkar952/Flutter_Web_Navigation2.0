/// Local Data Provider Interface class
abstract class LocalDataProviderContract {
  Future deleteData(
    String table, {
    String? whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
    List<String> keys = const [],
  }) async {}
  Future<void> insertData(String table, Map<String, dynamic> values) async {}
  Future<Map<String, dynamic>> readData(
    String table, {
    bool distinct,
    List<String> keys = const [],
    List<String> columns = const [],
    String whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
    String groupBy,
    String having,
    String orderBy,
    int limit,
  });

  Future updateData(
    String table,
    Map<String, dynamic> values, {
    String? whereClauseValue,
    List<dynamic> whereClauseArgs = const [],
  }) async {}
}
