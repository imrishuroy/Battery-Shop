import 'dart:async';

import 'package:admin_battery/constants/urls.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/rest-apis/rest_apis_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sky_event.dart';
part 'sky_state.dart';

class SkyBloc extends Bloc<SkyEvent, SkyState> {
  final RestApisRepository _apisRepository;
  StreamSubscription? _batterySubscription;

  SkyBloc({required RestApisRepository restApisRepository})
      : _apisRepository = restApisRepository,
        super(SkyState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(Urls.skyUrl))
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
        Stream.fromFuture(_apisRepository.getBatteries(Urls.skyUrl))
            .listen((batteries) => add(LoadSkyBatteries(batteries: batteries)));
  }
}
