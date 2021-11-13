import '/models/battery.dart';
import '/models/failure.dart';

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'luminous_event.dart';
part 'luminous_state.dart';

class LuminousBloc extends Bloc<LuminousEvent, LuminousState> {
  final _apisRepository;
  StreamSubscription? _batterySubscription;

  final String _path;

  LuminousBloc({
    required repository,
    required String path,
  })  : _apisRepository = repository,
        _path = path,
        super(LuminousState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(_path)).listen(
            (batteries) => add(LoadLuminousBatteries(batteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<LuminousState> mapEventToState(
    LuminousEvent event,
  ) async* {
    if (event is LoadLuminousBatteries) {
      yield* _mapLoadExideBatteriesToState(event);
    } else if (event is RefreshLuminousBatteries) {
      yield* _mapRefreshExideBatteryToState();
    }
  }

  Stream<LuminousState> _mapLoadExideBatteriesToState(
      LoadLuminousBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: LuminousStatus.loaded,
    );
  }

  Stream<LuminousState> _mapRefreshExideBatteryToState() async* {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(_path)).listen(
            (batteries) => add(LoadLuminousBatteries(batteries: batteries)));
  }
}
