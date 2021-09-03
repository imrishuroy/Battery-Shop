import 'dart:async';

import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'set_priority_event.dart';
part 'set_priority_state.dart';

class SetPriorityBloc extends Bloc<SetPriorityEvent, SetPriorityState> {
  StreamSubscription? _batterySubscription;
  final BatteryRepository _batteryRepository;
  final String? _vehicleBrandId;
  final String? _vehicleId;
  final FuelType _fuelType;

  SetPriorityBloc({
    required BatteryRepository batteryRepository,
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
  })  : _batteryRepository = batteryRepository,
        _vehicleBrandId = vehicleBrandId,
        _vehicleId = vehicleId,
        _fuelType = fuelType,
        super(SetPriorityState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription = _batteryRepository
        .streamVehiclesBatteries(
            vehicleBrandId: _vehicleBrandId,
            fuelType: _fuelType,
            vehicleId: _vehicleId)
        .listen((snaps) async {
      final batteries = await Future.wait(snaps);
      add(LoadPriorityBatteries(batteries: batteries));
    });
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<SetPriorityState> mapEventToState(
    SetPriorityEvent event,
  ) async* {
    if (event is LoadPriorityBatteries) {
      yield* _mapLoadPriorityBatteriesToState(event);
    } else if (event is UpdateBatteryPriority) {
      _mapUpdateBatteryPriorityToState(event);
    }
  }

  Stream<SetPriorityState> _mapLoadPriorityBatteriesToState(
      LoadPriorityBatteries event) async* {
    yield state.copyWith(
      batteries: event.batteries,
      status: PriortyStatus.succuss,
    );
  }

  Stream<SetPriorityState> _mapUpdateBatteryPriorityToState(
      UpdateBatteryPriority event) async* {
    await _batteryRepository.editBatteryPriority(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
      //   battery: event.newIndex,
      type: event.type1,

      priority: event.newIndex,
    );

    await _batteryRepository.editBatteryPriority(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
      //  battery: event.oldIndex,
      type: event.type2,
      priority: event.oldIndex,
    );
    // _batterySubscription = _batteryRepository
    //     .streamVehiclesBatteries(
    //         vehicleBrandId: _vehicleBrandId,
    //         fuelType: _fuelType,
    //         vehicleId: _vehicleId)
    //     .listen((snaps) async {
    //   final batteries = await Future.wait(snaps);
    //   add(LoadPriorityBatteries(batteries: batteries));
    // });
  }
}
