import 'dart:async';

import '/constants/constants.dart';
import '/models/battery.dart';
import '/models/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exide_event.dart';
part 'exide_state.dart';

class ExideBloc extends Bloc<ExideEvent, ExideState> {
  final _apisRepository;
  StreamSubscription? _batterySubscription;
  final String _path;

  ExideBloc({
    required repository,
    required String path,
  })  : _apisRepository = repository,
        _path = path,
        super(ExideState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription =
        Stream.fromFuture(_apisRepository.getBatteries(_path)).listen(
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
