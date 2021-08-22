import 'dart:async';

import 'package:admin_battery/constants/constants.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/rest-apis/rest_apis_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exide_event.dart';
part 'exide_state.dart';

class ExideBloc extends Bloc<ExideEvent, ExideState> {
  final RestApisRepository _apisRepository;
  StreamSubscription? _batterySubscription;

  ExideBloc({required RestApisRepository restApisRepository})
      : _apisRepository = restApisRepository,
        super(ExideState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(Urls.exideUrl)).listen(
            (batteries) => add(LoadExideBatteries(batteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ExideState> mapEventToState(
    ExideEvent event,
  ) async* {
    if (event is LoadExideBatteries) {
      yield* _mapLoadExideBatteriesToState(event);
    } else if (event is RefreshExideBatteries) {
      yield* _mapRefreshExideBatteryToState();
    }
  }

  Stream<ExideState> _mapLoadExideBatteriesToState(
      LoadExideBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: ExideStatus.loaded,
    );
  }

  Stream<ExideState> _mapRefreshExideBatteryToState() async* {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(Urls.exideUrl)).listen(
            (batteries) => add(LoadExideBatteries(batteries: batteries)));
  }
}
