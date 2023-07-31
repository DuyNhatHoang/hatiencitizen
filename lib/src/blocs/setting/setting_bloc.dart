import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ha_tien_app/src/repositories/remote/setting/settingrepo.dart';

import 'bloc.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepo settingRepo;

  SettingBloc(this.settingRepo) : super(SettingInitial());
  @override
  SettingState get initialState => SettingInitial();

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if(event is GetSettingE){
      var data = await settingRepo.getSetting(event.key);
      if (data.getException != null) {
        print("GetRelatedUserFailure");
        yield Error();
      } else
      yield Success(data.data.value);
    }
    }
}
