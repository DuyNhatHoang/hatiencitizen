import 'package:meta/meta.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}

class Success extends SettingState {
  final String value;

  Success(this.value);
}

class Error extends SettingState {

}
