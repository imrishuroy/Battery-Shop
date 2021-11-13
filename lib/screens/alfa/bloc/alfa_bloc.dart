import 'dart:async';

import 'package:admin_battery/constants/constants.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alfa_event.dart';
part 'alfa_state.dart';

class AlfaBloc extends Bloc<AlfaEvent, AlfaState> {
  final _repository;

  StreamSubscription? _batterySubscription;

  final String _path;

  AlfaBloc({
    required repository,
    required String path,
  })  
  // Todo Add amaron url when fetching data form rest API
  : _repository = repository,
        _path = path,
        super(AlfaState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription = Stream.fromFuture(_repository.getBatteries(_path))
        .listen((batteries) => add(LoadAlfaBatteries(batteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();

    return super.close();
  }

  @override
  Stream<AlfaState> mapEventToState(
    AlfaEvent event,
  ) async* {
    if (event is LoadAlfaBatteries) {
      yield* _mapLoadAmaronBatteriesToState(event);
    } else if (event is RefreshAlfaBatteries) {
      yield* _mapRefreshAmaronBatteriesToState();
    }
  }

  Stream<AlfaState> _mapLoadAmaronBatteriesToState(
      LoadAlfaBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: AlfaStatus.loaded,
    );
  }

  Stream<AlfaState> _mapRefreshAmaronBatteriesToState() async* {
    _batterySubscription?.cancel();
    // yield state.copyWith(status: AmaronStatus.loading);
    _batterySubscription =
        Stream.fromFuture(_repository.getBatteries(Urls.amaronUrl)).listen(
            (batteries) => add(LoadAlfaBatteries(batteries: batteries)));
    //yield state.copyWith(status: AmaronStatus.loaded);
  }
}
