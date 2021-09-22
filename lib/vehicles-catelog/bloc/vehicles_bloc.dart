import 'dart:async';

import '/enums/enums.dart';
import '/models/failure.dart';
import '/models/vehicle.dart';
import '/repositories/firebase_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  final FirebaseServices _firebaseServices;
  StreamSubscription? _vehicleSubscription;
  final String? _vehicleBrandId;
  final FuelType _fuelType;
  final String _vehicleType;
  VehiclesBloc({
    required FirebaseServices firebaseServices,
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String vehicleType,
  })  : _firebaseServices = firebaseServices,
        _vehicleBrandId = vehicleBrandId,
        _fuelType = fuelType,
        _vehicleType = vehicleType,
        super(VehiclesState.initial()) {
    _vehicleSubscription?.cancel();
    _vehicleSubscription = _firebaseServices
        .vehiclesAssociatedWithBransStream(
            vehicleBrandId: _vehicleBrandId,
            fuelType: _fuelType,
            vehicleType: _vehicleType)
        .listen((vehicles) => add(LoadVehicles(vehicles: vehicles)));
  }

  @override
  Future<void> close() {
    _vehicleSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<VehiclesState> mapEventToState(
    VehiclesEvent event,
  ) async* {
    if (event is LoadVehicles) {
      yield* _mapLoadVehicleToState(event);
    } else if (event is RefreshVehiclesList) {
      yield* _mapRefreshVehiclesToState();
    }
  }

  Stream<VehiclesState> _mapLoadVehicleToState(LoadVehicles event) async* {
    print('Vehicles ${event.vehicles}');
    yield state.copyWith(
      vehicles: event.vehicles,
      status: VehicleStatus.succuss,
    );
  }

  Stream<VehiclesState> _mapRefreshVehiclesToState() async* {
    _vehicleSubscription?.cancel();
    _vehicleSubscription = _firebaseServices
        .vehiclesAssociatedWithBransStream(
            vehicleBrandId: _vehicleBrandId,
            fuelType: _fuelType,
            vehicleType: _vehicleType)
        .listen((vehicles) => add(LoadVehicles(vehicles: vehicles)));
  }
}
