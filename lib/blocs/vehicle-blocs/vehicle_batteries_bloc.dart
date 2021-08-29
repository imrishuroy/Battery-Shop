import 'dart:async';

import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicle_batteries_event.dart';
part 'vehicle_batteries_state.dart';

class VehicleBatteriesBloc
    extends Bloc<VehicleBatteriesEvent, VehicleBatteriesState> {
  StreamSubscription? _batterySubscription;

  final BatteryRepository _batteryRepository;
  final String? _vehicleBrandId;
  final FuelType _fuelType;
  final String? _vehicleId;

  VehicleBatteriesBloc({
    required BatteryRepository batteryRepository,
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
  })  : _batteryRepository = batteryRepository,
        _fuelType = fuelType,
        _vehicleBrandId = vehicleBrandId,
        _vehicleId = vehicleId,
        super(VehicleBatteriesState.initial()) {
    _batterySubscription?.cancel();
    _batterySubscription = _batteryRepository
        .streamVehiclesBatteries(
      vehicleBrandId: _vehicleBrandId,
      fuelType: _fuelType,
      vehicleId: _vehicleId,
    )
        .listen((batteries) async {
      final vehicleBatteries = await Future.wait(batteries);
      print('Vehicles Battery $vehicleBatteries');
      return add(LoadVehicleBatteries(vehicleBatteries: vehicleBatteries));
    });

    // _batterySubscription = _batteryRepository

    //     .streamRemoteBatteries(
    //         vehicleBrandId: _vehicleBrandId,
    //         fuelType: _fuelType,
    //         vehicleId: _vehicleId)
    //     .listen((batteries) =>
    //         add(LoadVehicleBatteries(vehicleBatteries: batteries)));
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }

  @override
  Stream<VehicleBatteriesState> mapEventToState(
    VehicleBatteriesEvent event,
  ) async* {
    if (event is LoadVehicleBatteries) {
      yield* _mapLoadVehicleBatteriesToState(event);
    }
  }

  Stream<VehicleBatteriesState> _mapLoadVehicleBatteriesToState(
      LoadVehicleBatteries event) async* {
    yield state.copyWith(
      vehicleBatteries: event.vehicleBatteries,
      status: VehicleBatteriesStatus.succuss,
    );
  }
}
