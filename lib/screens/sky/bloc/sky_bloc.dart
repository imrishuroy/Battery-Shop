import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/battery.dart';
import '/models/failure.dart';

import 'package:equatable/equatable.dart';

part 'sky_event.dart';
part 'sky_state.dart';

class SkyBloc extends Bloc<SkyEvent, SkyState> {
  final _apisRepository;
  StreamSubscription? _batterySubscription;

  final String _path;

  SkyBloc({
    required repository,
    required String path,
  })  : _apisRepository = repository,
        _path = path,
        super(SkyState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(_path))
            .listen((batteries) => add(LoadSkyBatteries(batteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<SkyState> mapEventToState(
    SkyEvent event,
  ) async* {
    if (event is LoadSkyBatteries) {
      yield* _mapLoadExideBatteriesToState(event);
    } else if (event is RefreshSkyBatteries) {
      yield* _mapRefreshExideBatteryToState();
    }
  }

  Stream<SkyState> _mapLoadExideBatteriesToState(
      LoadSkyBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: SkyStatus.loaded,
    );
  }

  Stream<SkyState> _mapRefreshExideBatteryToState() async* {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(_path))
            .listen((batteries) => add(LoadSkyBatteries(batteries: batteries)));
  }
}
