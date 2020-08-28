import 'package:parse_server_sdk/parse_server_sdk.dart';
class DietPlan extends ParseObject implements ParseCloneable {

  DietPlan() : super(_keyTableName);
  DietPlan.clone(): this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override clone(Map map) => DietPlan.clone()..fromJson(map);

  static const String _keyTableName = 'DietPlan';
  static const String keyName = 'Name';

  String get name => get<String>(keyName);
  set name(String name) => set<String>(keyName, name);
}