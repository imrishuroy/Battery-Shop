import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/battery.dart';
import '/models/failure.dart';

import 'package:equatable/equatable.dart';

part 'livfast_event.dart';
part 'livfast_state.dart';

class LivFastBloc extends Bloc<LivFastEvent, LivFastState> {
  final _apisRepository;
  StreamSubscription? _batterySubscription;

  final String _path;

  LivFastBloc({
    required repository,
    required String path,
  })  : _apisRepository = repository,
        _path = path,
        super(LivFastState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(_path)).listen(
            (batteries) => add(LoadLivFastBatteries(batteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<LivFastState> mapEventToState(
    LivFastEvent event,
  ) async* {
    if (event is LoadLivFastBatteries) {
      yield* _mapLoadExideBatteriesToState(event);
    } else if (event is RefreshLivFastBatteries) {
      yield* _mapRefreshExideBatteryToState();
    }
  }

  Stream<LivFastState> _mapLoadExideBatteriesToState(
      LoadLivFastBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: LivFastStatus.loaded,
    );
  }

  Stream<LivFastState> _mapRefreshExideBatteryToState() async* {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(_path)).listen(
            (batteries) => add(LoadLivFastBatteries(batteries: batteries)));
  }
}
