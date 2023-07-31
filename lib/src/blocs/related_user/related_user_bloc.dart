import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ha_tien_app/src/repositories/models/events/related_user_event.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/repositories/remote/server_error.dart';
import 'package:meta/meta.dart';

part 'related_user_event.dart';
part 'related_user_state.dart';

class RelatedUserBloc extends Bloc<RelatedUserEvent, GetRelatedState> {
  final EventsRepo repo;

  RelatedUserBloc(this.repo) : super(InitialRelatedUserState());

  @override
  GetRelatedState get initialState => InitialRelatedUserState();

  @override
  Stream<GetRelatedState> mapEventToState(RelatedUserEvent event) async* {
    if (event is GetRelateEvent) {
      var data = await repo.getRelateUserEvent(event.request);
      if (data.getException != null) {
        print("GetRelatedUserFailure");
        yield GetRelatedUserFailure(data.getException);
      } else
        print("GetRelatedUserSuccess ${data.data.employees.length}");
      yield GetRelatedUserSuccess(data.data);
    }
  }
}
