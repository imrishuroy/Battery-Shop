import 'dart:async';

import 'package:admin_battery/constants/urls.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/rest-apis/rest_apis_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'amaron_event.dart';
part 'amaron_state.dart';

class AmaronBloc extends Bloc<AmaronEvent, AmaronState> {
  final _repository;
  StreamSubscription? _batterySubscription;

  AmaronBloc({required repository, required String path})
      // TODO: Add amaron url when fetching data form rest API
      : _repository = repository,
        super(AmaronState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription = Stream.fromFuture(_repository.getBatteries(path))
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
