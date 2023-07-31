import 'package:meta/meta.dart';

@immutable
abstract class SettingEvent {}

class GetSettingE extends SettingEvent{
  final String key;

  GetSettingE(this.key);
}
