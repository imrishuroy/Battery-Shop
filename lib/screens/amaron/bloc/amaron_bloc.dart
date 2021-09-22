import 'dart:async';

import '/constants/urls.dart';
import '/models/battery.dart';
import '/models/failure.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'amaron_event.dart';
part 'amaron_state.dart';

class AmaronBloc extends Bloc<AmaronEvent, AmaronState> {
  final _repository;

  StreamSubscription? _batterySubscription;

  final String _path;

  AmaronBloc({
    required repository,
    required String path,
  })  
  // Todo Add amaron url when fetching data form rest API
  : _repository = repository,
        _path = path,
        super(AmaronState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription = Stream.fromFuture(_repository.getBatteries(_path))
        .listen((batteries) => add(LoadAmaronBatteries(batteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();

    return super.close();
  }

  @override
  Stream<AmaronState> mapEventToState(
    AmaronEvent event,
  ) async* {
    if (event is LoadAmaronBatteries) {
      yield* _mapLoadAmaronBatteriesToState(event);
    } else if (event is RefreshAmaronBatteries) {
      yield* _mapRefreshAmaronBatteriesToState();
    }
  }

  Stream<AmaronState> _mapLoadAmaronBatteriesToState(
      LoadAmaronBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: AmaronStatus.loaded,
    );
  }

  Stream<AmaronState> _mapRefreshAmaronBatteriesToState() async* {
    _batterySubscription?.cancel();
    // yield state.copyWith(status: AmaronStatus.loading);
    _batterySubscription =
        Stream.fromFuture(_repository.getBatteries(Urls.amaronUrl)).listen(
            (batteries) => add(LoadAmaronBatteries(batteries: batteries)));
    //yield state.copyWith(status: AmaronStatus.loaded);
  }
}
