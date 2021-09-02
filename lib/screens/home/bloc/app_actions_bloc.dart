import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_actions_event.dart';
part 'app_actions_state.dart';

class AppActionsBloc extends Bloc<AppActionsEvent, AppActionsState> {
  AppActionsBloc() : super(AppActionsState.initial());

  @override
  Stream<AppActionsState> mapEventToState(
    AppActionsEvent event,
  ) async* {
    if (event is ChangeActionStatus) {
      yield* _mapChangeActionToState(event);
    }
  }

  Stream<AppActionsState> _mapChangeActionToState(
      ChangeActionStatus event) async* {
    yield state.copyWith(status: event.status);
  }
}
